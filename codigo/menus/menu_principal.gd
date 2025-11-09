extends Control
@onready var conf_info_screen: ColorRect = $Conf_Info_Screen
@onready var informacion: TextureRect = $Conf_Info_Screen/Informacion
@onready var menu_configuracion: Control = $Conf_Info_Screen/MenuConfiguracion

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _confirmar_cambios_audio():
	pass

""" Configuracion de botones """
func _on_informacion_pressed() -> void:
	conf_info_screen.show()
	informacion.show()
	pass # Replace with function body.

func _on_salir_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.

func _on_conf_pressed() -> void:
	conf_info_screen.show()
	menu_configuracion.show()
	pass # Replace with function body.

func _on_cargar_pressed() -> void:
	pass # Replace with function body.

func _on_nueva_pressed() -> void:
	pass # Replace with function body.

func _on_exit_pop_panel_pressed() -> void:
	conf_info_screen.hide()
	menu_configuracion.hide()
	menu_configuracion.hide()
