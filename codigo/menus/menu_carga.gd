extends Control
@onready var titulo: Label = $"Seleccionar partida/titulo"
@onready var gestor_partidas: Node = $GestorPartidas
#labels de partida
@onready var label_partidas: VBoxContainer = $"Seleccionar partida/Label_Partidas"
@onready var label_niveles: VBoxContainer = $"Seleccionar partida/Label_Niveles"
#botones de partida
@onready var partidas: GridContainer = $"Seleccionar partida/PanelContainer/MarginContainer/Partidas"
#opciones de nueva partida
@onready var nueva_partida_screen: ColorRect = $Nueva_Partida_Screen
@onready var nuevo_nombre: LineEdit = $Nueva_Partida_Screen/ingresar_nombre_panel/MarginContainer/VBoxContainer/LineEdit

func _ready() -> void:
	InfoPartida.nueva_partida=true
	_actualizar_titulo()
	_mostrar_slots_activos()
	_mostrar_info_partida()
	pass # Replace with function body.

func _on_regresar_pressed() -> void:
	get_tree().change_scene_to_file("res://RBS/escenas/menus/menu_principal.tscn")

func _actualizar_titulo():
	if InfoPartida.nueva_partida:
		titulo.text = "nueva partida"
	else:
		titulo.text = "cargar partida"
	
""" GUI PARTIDAS -----------------------------------------------------"""
func _actualizar_labels_partida(partida:Dictionary, nombre:Label, nivel:Label):
	if partida["nombre"] != "-":
		nombre.text = partida["nombre"]
		nivel.text = "nivel  " + str(partida["nivel"])
	else:
		nombre.text = "(vacío)"
		nombre.set("theme_override_colors/font_color", Color(1,1,1,0.5))
		nivel.text = "nivel  -"
		nivel.set("theme_override_colors/font_color", Color(1,1,1,0.5))
		
func _habilitar_slot(partida:Dictionary, boton: Button):
	if partida["nombre"] != "-":
		boton.disabled = false
	else:
		boton.disabled = true

func _mostrar_slots_activos():
	if InfoPartida.nueva_partida == false:
		_habilitar_slot(gestor_partidas.get_partida(1), partidas.get_node("btn_partida_1"))
		_habilitar_slot(gestor_partidas.get_partida(2), partidas.get_node("btn_partida_2"))
		_habilitar_slot(gestor_partidas.get_partida(3), partidas.get_node("btn_partida_3"))

func _mostrar_info_partida():
	_actualizar_labels_partida(gestor_partidas.get_partida(1), label_partidas.get_node("label_partida1"), label_niveles.get_node("label_nivel1"))
	_actualizar_labels_partida(gestor_partidas.get_partida(2), label_partidas.get_node("label_partida2"), label_niveles.get_node("label_nivel2"))
	_actualizar_labels_partida(gestor_partidas.get_partida(3), label_partidas.get_node("label_partida3"), label_niveles.get_node("label_nivel3"))
"""-------------------------------------------------------------------------"""

"""NUEVA PARTIDA-------------------------------------------------------------"""
# ---------- de sobreescpcion -------------

func _on_confirmar_pressed() -> void:
	nueva_partida_screen.get_node("sobreescribir_panel").hide()
	nueva_partida_screen.get_node("ingresar_nombre_panel").show()

func _on_cancelar_pressed() -> void:
	nueva_partida_screen.hide()
	nueva_partida_screen.get_node("sobreescribir_panel").hide()

# ---------- de ingresar nombre ------------	
func _on_cancelar_2_stage_pressed() -> void:
	nueva_partida_screen.hide()
	nueva_partida_screen.get_node("ingresar_nombre_panel").hide()

func _on_confirmar_2_stage_pressed() -> void:
	if _verificar_nombre_nuevo():
		_nueva_partida(nuevo_nombre.text)
		pass
	
func _nueva_partida(nombre:String):
	InfoPartida.partida_actual["nombre"] = nombre
	gestor_partidas.nueva_partida(nombre, InfoPartida.id_partida_actual)

func _confirmar_nueva_partida(nombre: String):
	nueva_partida_screen.show()
	if nombre != "-": #si la partida no esta vacia, confirmar sobreescripcion
		nueva_partida_screen.get_node("sobreescribir_panel").show()
	else: #sino, mostrar panel para que pongan el nombre
		nueva_partida_screen.get_node("ingresar_nombre_panel").show()
		
func _verificar_nombre_nuevo()->bool:
	var nombre = nueva_partida_screen.get_node("ingresar_nombre_panel/MarginContainer/VBoxContainer/LineEdit").text
	if len(nombre) >= 3:
		if nombre.to_lower() == "(vacío)" || nombre.to_lower()=="(vacio)":
			nueva_partida_screen.get_node("ingresar_nombre_panel/avisoTamNombre").text = "ja-ja-ja, muy gracioso. . . Elige otro nombre."
			return false
		for n in gestor_partidas.get_nombres():
			if nombre == n["nombre"]:
				nueva_partida_screen.get_node("ingresar_nombre_panel/avisoTamNombre").text = "Ese nombre ya existe, elige uno nuevo."
				return false
	else:
		nueva_partida_screen.get_node("ingresar_nombre_panel/avisoTamNombre").text = "Ingresa al menos 3 caracteres."
		return false
	return true
"""----------------------------------------------------------------------"""	
	
"""  SELECCION DE PARTIDA ------------------------------------------"""
func _elegir_partida(id: int):
	var partida = gestor_partidas.get_partida(id)
	InfoPartida.set_partida_actual(partida, id) #establecer desde aqui, si hacen nueva partida, se actualiza
	if InfoPartida.nueva_partida:
		_confirmar_nueva_partida(partida["nombre"])
	else:
		get_tree().change_scene_to_file("res://RBS/escenas/menus/menu_niveles.tscn")

func _on_btn_partida_1_pressed() -> void:
	_elegir_partida(1)
	pass # Replace with function body.

func _on_btn_partida_2_pressed() -> void:
	_elegir_partida(2)
	pass # Replace with function body.

func _on_btn_partida_3_pressed() -> void:
	_elegir_partida(3)
	pass # Replace with function body.
