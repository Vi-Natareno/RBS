extends Node
@onready var enemigo: AnimatedSprite2D = $".."
#posicion
const LUGAR_LIBERACION = 60
var velocidad: float = 100 #se sobreescribe en midi_event()

#puntuacion
var tiempo_llegada:float = 0 #se asigna en el midi ez
var TOLERANCIA_TIEMPO_ANOTACION := {
	"PERFECT": 0.1,
	"OK": 0.18
}
	
func _process(delta: float) -> void:
	#print(Puntuador.i_en)
	enemigo.position.x -= velocidad * delta

func pasar_lugar_liberacion(target_pos: Vector2)->bool:
	if enemigo.position.x < LUGAR_LIBERACION:
		enemigo.queue_free()
		Puntuador.anotar_puntos(Puntuador.Tipo_Anotacion.MISS, target_pos)
		#print("miss")
		return true
	return false

#para probar si se anotó o no al menos dentro de un OK
func evaluar_golpe_acertado(delta_sum:float)->bool:
	#print(abs(tiempo_llegada - delta_sum), "          ", TOLERANCIA_TIEMPO_ANOTACION.OK)
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
