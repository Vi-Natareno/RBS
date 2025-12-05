extends Node
@onready var enemigo: AnimatedSprite2D = $".."
@onready var barra_vida = $"../../../HUD/barra_vida"
var timer := Timer.new()
const MACHINE_POWER_OFF = preload("uid://ctbounrk7uwki")
var efecto := AudioStreamPlayerADSR.new()
#posicion
const LUGAR_LIBERACION = 60
var velocidad: float = 0 #se sobreescribe en midi_event()
#puntuacion
var tiempo_llegada:float = 0 #se asigna en el midi ez
var TOLERANCIA_TIEMPO_ANOTACION := {
	"PERFECT": Ritmo.tolerancia_perfect,
	"OK": Ritmo.tolerancia_ok
}
func _ready() -> void:
	add_child(timer)
	add_child(efecto)
	efecto.stream = MACHINE_POWER_OFF
	efecto.bus = "SFX"
	timer.wait_time = 0.8
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)
	
func _process(delta: float) -> void:
	enemigo.position.x -= velocidad * delta
	if InfoPartida.vida_actual == 0 and InfoPartida.audio_active == true:
		efecto.play()
		InfoPartida.audio_active = false
		$"../../../Musica/AudioStreamPlayer2D".stop()
		timer.start()

func pasar_lugar_liberacion(target_pos: Vector2)->bool:
	if enemigo.position.x < LUGAR_LIBERACION:
		enemigo.queue_free()
		Puntuador.anotar_puntos(Puntuador.Tipo_Anotacion.MISS, target_pos)
		#print("miss")
		if InfoPartida.vida_actual > 1: 
			InfoPartida.vida_actual -= 1
			if InfoPartida.vida_actual % 4 == 0:
				barra_vida.desaparecer_corazon()
			barra_vida.actualizar_barra_vida()
			
		else: 
			InfoPartida.vida_actual -= 1
			barra_vida.desaparecer_corazon()
			Engine.time_scale = 0.5
		return true
	return false

#para probar si se anotó o no al menos dentro de un OK
func evaluar_golpe_acertado(delta_sum:float)->bool:
	#print("transcurrido: ",  delta_sum," llega: ", tiempo_llegada,  "diferencia: ", abs(tiempo_llegada - delta_sum))
	return abs(tiempo_llegada - delta_sum) <= TOLERANCIA_TIEMPO_ANOTACION.OK 
	
#despues de saber que se acertó un golpe
func recibir_golpe(delta_sum:float, target_pos:Vector2, half:bool = false):
	var diferencia = abs(delta_sum - tiempo_llegada)
	if not half:
		if diferencia <= TOLERANCIA_TIEMPO_ANOTACION.PERFECT:
			Puntuador.anotar_puntos(Puntuador.Tipo_Anotacion.PERFECT, target_pos)
			#print("p")
		else:
			Puntuador.anotar_puntos(Puntuador.Tipo_Anotacion.OK, target_pos)
			#print("k")
	if half:
		Puntuador.anotar_puntos(Puntuador.Tipo_Anotacion.OK, target_pos)
		#print("OK HALF")
	enemigo.queue_free()

func _on_timer_timeout():
	InfoPartida.is_platform = true
	Engine.time_scale = 1
	InfoPartida.vida_actual = InfoPartida.vida_final_plataforma
	get_tree().change_scene_to_file("res://RBS/escenas/juego/plataformas/plat_1.tscn")
