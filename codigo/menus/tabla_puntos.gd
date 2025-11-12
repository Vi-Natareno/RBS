extends TextureRect
@onready var top1: Label = $"MarginContainer/VBoxContainer/1"
@onready var top2: Label = $"MarginContainer/VBoxContainer/2"
@onready var top3: Label = $"MarginContainer/VBoxContainer/3"
@onready var gestor_puntuaciones: Node = $GestorPuntuaciones

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _imprimir_ranking(ranking: Array):
	var concat = ["","",""]
	var i:int = 0
	for diccionario in ranking:
		if diccionario["puntuacion"] != "-":
			concat[i] = diccionario["nombre"] + "   " + diccionario["puntuacion"]
		else:
			concat[i] = ". . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . ."
		i+=1
	top1.text = "1.   " + concat[0]
	top2.text = "2.   " + concat[1]
	top3.text = "3.   " + concat[2]

func mostrar_tabla(nivel_actual:int):
	var ranking = gestor_puntuaciones.get_puntuacion(nivel_actual)
	_imprimir_ranking(ranking)
	pass
