"""administra la partida actual solamente, ya no llama al gestor"""
extends Node
var nueva_partida = false
var id_partida_actual: int = -1
var partida_actual:Dictionary = {"nombre": "test_default", "nivel": 1}
var nombres


func _ready() -> void:
	pass # Replace with function body.
	
func set_partida_actual(partida, id):
	id_partida_actual = id
	partida_actual = partida
	
