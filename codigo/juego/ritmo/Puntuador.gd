extends Node
const ANOTACION = preload("uid://beeyne5t16agd")
@onready var anotacion_labels =  get_node("/root/ritmo_1/MarcadorAtaque/Anotacion_labels")
var puntos:int = 0
var puntos_graficados = 0
enum Tipo_Anotacion {PERFECT, OK, MISS}

var i_en = 0 #para evaluar notas que no responden

func anotar_puntos(tipo: Tipo_Anotacion, target_pos:Vector2):
	match(tipo):
		Tipo_Anotacion.PERFECT:
			puntos += 200
			_graficar_feedback("PERFECT!", target_pos)
		Tipo_Anotacion.OK:
			puntos += 100
			_graficar_feedback("OK!", target_pos)
		Tipo_Anotacion.MISS:
			puntos -=20
			_graficar_feedback("MISS", target_pos)
			
func _process(delta: float) -> void:
	actualizar_puntos()
	pass

func actualizar_puntos() -> void:
	var diferencia = abs(puntos - puntos_graficados)
	var paso = max(1, diferencia * 0.2)
	if puntos_graficados < puntos:
		puntos_graficados =  min(puntos_graficados + paso, puntos);
	elif puntos_graficados > puntos:
		puntos_graficados = max(puntos_graficados - paso,puntos)
	puntos_graficados = int(puntos_graficados)

func _graficar_feedback(tipo_anotacion: String, target_pos: Vector2):
	var feedback = ANOTACION.instantiate()
	feedback.cambiar_texto(tipo_anotacion)
	feedback.global_position = target_pos
	anotacion_labels.add_child(feedback)
