extends Control
@onready var conf_info_screen: ColorRect = $Conf_Info_Screen
@onready var informacion: TextureRect = $Conf_Info_Screen/Informacion
const MENU_CONFIGURACION = preload("uid://c0on1tc0dlc77")
@onready var menu_configuracion: Control = $Conf_Info_Screen/MenuConfiguracion

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
""" Configuracion de botones """
func _on_informacion_pressed() -> void:
	conf_info_screen.show()
	informacion.show()

func _on_salir_pressed() -> void:
	Data.db.close_db()
	get_tree().quit()

func _on_conf_pressed() -> void:
	conf_info_screen.show()
	menu_configuracion.show()
	menu_configuracion.reproducir_audio()
	
func _on_cargar_pressed() -> void:
	InfoPartida.nueva_partida = false
	get_tree().change_scene_to_file("res://RBS/escenas/menus/menu_carga.tscn")

func _on_nueva_pressed() -> void:
	InfoPartida.nueva_partida = true
	get_tree().change_scene_to_file("res://RBS/escenas/menus/menu_carga.tscn")

func _on_cerrar_pressed() -> void:
	conf_info_screen.hide()
	informacion.hide()
	pass # Replace with function body.
