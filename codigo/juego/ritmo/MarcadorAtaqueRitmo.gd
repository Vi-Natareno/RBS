extends Node2D
const SLIME = preload("uid://gjvyhusvxcfc")
@onready var enemigos: Node = $Enemigos
@onready var label_puntos: Label = $GameObjects/HUD/puntos
const DISTANCIA_INSTANCIACION_X: float = 215  #215 en pixeles, distancia de camino hasta el marcador


# VELOCIDAD DE NOTA-----------------DB--------------------------------------------------------
var escala_velocidad:float = Ritmo.escala_velocidad #separacion
# ------------Iniciar el midi al tiempo correcto----------------
var tiempo_transcurrido: float = 0 #suma delta desde el inicio
var tiempo_desde_MIDI: float = 0 #suma delta desde el inicio del midi
var inicio_audio: float = Ritmo.inicio_audio #DB
# AJUSTES DE TIEMPO PARA ANOTACION PERFECT Y OK--------------DB-------------------------------
#cuando el MIDI player inicia, la nota se instancia hasta la derecha, pero ya necesita estar en el marcador
#para eso esta el desfase de tiempo
var desfase_tiempo:float = Ritmo.desfase_tiempo #segundos que tarda la nota en caer en el centro del marcador 
var tiempo_espera: float = Ritmo.tiempo_espera #segundos antes de iniciar el midi

@onready var notas: Dictionary = {
	#mi, doble superior
	 52: { #52,36
		"target_pos":  Vector2(85.4,32.4),
		"color": "pink_slime",
	  "marcador": get_node("MarcadorAtaque/Marcador_superior"),
	  "escala": Vector2(1.5,1.5),
	  "cola": []
	},
	#mi bemol, superior
	51: { #51,40
		"target_pos":  Vector2(85.4,32.4),
		"color": "green_slime",
	  "marcador": get_node("MarcadorAtaque/Marcador_superior"),
	  "escala": Vector2(1,1),
	  "cola": []
	 },
	#re, doble inferior
	49: { #38
		"target_pos": Vector2(85.2,77),
		"color": "pink_slime",
		"marcador": get_node("MarcadorAtaque/Marcador_inferior"),
		"escala": Vector2(1.5,1.5),
		"cola": []
	},
	#re bemol,inferior
	50: { #42
		"target_pos": Vector2(85.2,77),
		"color": "green_slime",
		"marcador": get_node("MarcadorAtaque/Marcador_inferior"),
		"escala": Vector2(1,1),
		"cola": []
	}	
}

"""pruebas tiempo--------------------------------------------------"""
@onready var timer: Timer = $Timer
@onready var enemy_test: AnimatedSprite2D = $Enemigos/enemy_test
func test_tiempo_llegada():
	var centro = enemy_test.position.x < 82 and enemy_test.position.x > 80 #para sacar el tiempo que tarda en llegar al centro y por ende, los rangos de los laterales
	var rango_ok = enemy_test.position.x < 96 and enemy_test.position.x > 69
	var rango_perfect = enemy_test.position.x < 86 and enemy_test.position.x > 74
	#var adelantado =  enemy_test.position.x < 126 and enemy_test.position.x > 124
	#var miss = enemy_test.position.x < 60 and enemy_test.position.x > 45
	if tiempo_transcurrido >= tiempo_espera-desfase_tiempo:
		enemy_test.get_node("NotaRitmo").velocidad = DISTANCIA_INSTANCIACION_X * escala_velocidad
		if centro:
			print("test: ",timer.wait_time - timer.time_left)
			pass
func inicializar_enemy_test():
	enemy_test.get_node("NotaRitmo").velocidad = 0
	enemy_test.play("green_slime")
"""pruebas tiempo -------------------------------------------------"""

# INICIO MIDI Y AUDIO---------------------------------------------------------------------------
func _configurar_midi_audio():
	$Musica/MidiPlayer.set_file(Ritmo.midi)
	$Musica/AudioStreamPlayer2D.set_stream(Ritmo.get_audio(InfoPartida.nivel_actual))
func _iniciar_midi():
	if tiempo_desde_MIDI >= 10:
		$Musica/MidiPlayer._stop_all_notes()
	else:
		if tiempo_transcurrido >= tiempo_espera - desfase_tiempo and not $Musica/MidiPlayer.playing:
			tiempo_desde_MIDI = 0
			$Musica/MidiPlayer.play()
			$Timer.start()
#####---- ESTE ES QUE EL TOMA EN CUENTA EL DESFASE DE TIEMPO DE LA NOTA -------##########
func _iniciar_audio():
	if not $Musica/AudioStreamPlayer2D.playing:
		$Musica/AudioStreamPlayer2D.play(inicio_audio)
# INICIO MIDI Y AUDIO---------------------------------------------------------------------------

func _ready() -> void:
	inicializar_enemy_test()
	label_puntos.text = str(0)
	_configurar_midi_audio()

func _process(delta: float) -> void:
	test_tiempo_llegada()
	label_puntos.text = str(Puntuador.puntos_graficados)
	tiempo_desde_MIDI += delta
	tiempo_transcurrido += delta
	_verificar_pulsacion_entrada()
	_evaluar_golpe_no_anotado()
	_iniciar_audio()
	_iniciar_midi()
	

@warning_ignore("unused_parameter")
func _on_midi_player_midi_event(channel: Variant, event: Variant) -> void:
	if event.type == SMF.MIDIEventType.note_on:
		#print(event.note)
		var datos_nota: Dictionary = notas.get(event.note) #obtener Dict de la nota correspondiente
		if datos_nota: #si existen datos de ese event.note
			var enemigo = SLIME.instantiate()
			enemigo.global_position =   datos_nota["marcador"].global_position +  Vector2(DISTANCIA_INSTANCIACION_X,14)
			enemigo.get_node("NotaRitmo").velocidad = DISTANCIA_INSTANCIACION_X * escala_velocidad
			enemigo.z_index = 6
			enemigo.scale = datos_nota["escala"]
			#print(tiempo_desde_MIDI + desfase_tiempo) #deberia ser como 2 segundos
			enemigo.get_node("NotaRitmo").tiempo_llegada = tiempo_desde_MIDI + desfase_tiempo
			$Enemigos.add_child(enemigo)
			enemigo.play(datos_nota["color"])
			datos_nota["cola"].push_back(enemigo) #agregar "nota" a la cola

func _verificar_pulsacion_entrada():
	if Input.is_action_pressed("F") and Input.is_action_pressed("J"):
		_evaluar_golpe(notas[50]) #38
		_graficar_pulsacion($MarcadorAtaque/Marcador_inferior)
	elif Input.is_action_just_pressed("F") or Input.is_action_just_pressed("J"):
		_evaluar_golpe(notas[50]) #42
		_evaluar_golpe(notas[49], true) #para no penalizar tanto si no se detecta el doble golpe
		_graficar_pulsacion($MarcadorAtaque/Marcador_inferior)
		#print(timer.wait_time - timer.time_left)
	if Input.is_action_pressed("E") and Input.is_action_pressed("I"):
		_evaluar_golpe(notas[52]) #36
		_graficar_pulsacion($MarcadorAtaque/Marcador_superior)
	elif Input.is_action_just_pressed("E") or Input.is_action_just_pressed("I"):
		_evaluar_golpe(notas[51]) #40
		_evaluar_golpe(notas[52], true)
		_graficar_pulsacion($MarcadorAtaque/Marcador_superior)
		#print(timer.wait_time - timer.time_left)

func _evaluar_golpe(info_nota_dAtaque: Dictionary, half: bool = false):
	if not info_nota_dAtaque["cola"].is_empty():
		var sig_nota: Node2D = info_nota_dAtaque["cola"].front()
		#si acertó en tiempo alguna nota
		if sig_nota.get_node("NotaRitmo").evaluar_golpe_acertado(tiempo_desde_MIDI):
			info_nota_dAtaque["cola"].pop_front().get_node("NotaRitmo").recibir_golpe(tiempo_desde_MIDI, info_nota_dAtaque["target_pos"] ,half)

#es constante en process, destruir al llegar a canelita
func _evaluar_golpe_no_anotado():
	for diccionario in notas.values():
		if not diccionario["cola"].is_empty():
			if diccionario["cola"].front().get_node("NotaRitmo").pasar_lugar_liberacion(diccionario["target_pos"]):
				diccionario["cola"].pop_front()

func _graficar_pulsacion(btn: Sprite2D) -> void: #animación
	Puntuador.i_en +=1
	var tween = get_tree().create_tween()
	tween.tween_property(btn,"scale",Vector2(0.8, 0.8),0.06)
	tween.tween_property(btn, "modulate", Color(1,1,1,0.5), 0.06)
	tween.tween_property(btn,"scale",Vector2(1, 1),0.06)
	tween.tween_property(btn, "modulate", Color(1,1,1,1), 0.06)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("E") or Input.is_action_just_pressed("I") or Input.is_action_just_pressed("F") or Input.is_action_just_pressed("J"):
		$Musica/efecto.play()
