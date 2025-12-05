"""administra la partida actual solamente, ya no llama al gestor"""
extends Node
var nueva_partida = false
var id_partida_actual: int = -1
var partida_actual:Dictionary = {"nombre": "test_default", "nivel": 1}
var nivel_actual := 1 #reiniciar en boton

#manejo de valores iniciales en ambos juegos
var is_platform = false #reinicar en boton
var vida_actual = 32  #reiniciar en boton
var vida_final_plataforma = 10 #reiniciar en boton, este es un ejemplo si lo pruebas desde la escena ritmo, te va a reiniciar al nivel plataforma en esa vida
var corazones_reales = 8 #reiniciar en boton

#perder en nivel de ritmo
var last_positions := [Vector2(840,-133), Vector2(970,-280)]

var perder_en_ritmo = false #reiniciar?
var last_plat_position = last_positions[nivel_actual-1]


func _ready() -> void:
	pass # Replace with function body.
	
func set_partida_actual(partida, id):
	id_partida_actual = id
	InfoPartida.vida_actual = 32
	partida_actual = partida
	
func set_jugar_nivel():
	is_platform = true
	vida_actual = 32
	vida_final_plataforma = 0
	corazones_reales = 8
	perder_en_ritmo = false
