"""administra la partida actual solamente, ya no llama al gestor"""
extends Node
var nueva_partida = false
var id_partida_actual: int = -1
var partida_actual:Dictionary = {"nombre": "test_default", "nivel": 1}
var nivel_actual := 1
var audio_active = true
var is_platform = true

var vida_actual = 32
var vida_final_plataforma = 32

func _ready() -> void:
	pass # Replace with function body.
	
func set_partida_actual(partida, id):
	id_partida_actual = id
	InfoPartida.vida_actual = 32
	partida_actual = partida
	
