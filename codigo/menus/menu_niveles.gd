extends Control

@onready var nodo_camara: Node2D = $Nodo_camara
@onready var tabla_puntos: TextureRect = $CanvasLayer/TablaPuntos
const NIVEL_MAX_CREADO = 5
var nivel_actual:int = 1
var camara_pos_origen = Vector2(0,0)
var camara_pos_limite = Vector2(2744,0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_establecer_niveles_bloqueado(InfoPartida.partida_actual["nivel"])
	#inicializar GUI
	_inicializar_GUI()
	nivel_actual = 1 #inicializar nivel
	pass # Replace with function body.

func _on_regresar_pressed() -> void:
	get_tree().change_scene_to_file("res://RBS/escenas/menus/menu_carga.tscn")

""" GUI CAMARA --------------------------------------------------------"""
func _inicializar_GUI():
	Input.warp_mouse(Vector2(900,200))
	$CanvasLayer/limite_izquierdo.modulate = Color(1,1,1,0.35)
	$CanvasLayer/limite_derecho.modulate = Color(1,1,1,0.35)
	
func _on_izquierda_mouse_exited() -> void:
	$CanvasLayer/limite_izquierdo.modulate = Color(1,1,1,0.35)

func _on_derecha_mouse_exited() -> void:
	$CanvasLayer/limite_derecho.modulate = Color(1,1,1,0.35)

func _on_derecha_mouse_entered() -> void:
	tabla_puntos.hide()
	if nodo_camara.position != camara_pos_limite:
		nivel_actual += 1
		$CanvasLayer/limite_derecho.modulate = Color(1,1,1,0.65)
		nodo_camara.global_position += Vector2(686,0)

func _on_izquierda_mouse_entered() -> void:
	tabla_puntos.hide()
	if nodo_camara.position != camara_pos_origen:
		nivel_actual -= 1
		$CanvasLayer/limite_izquierdo.modulate = Color(1,1,1,0.65)
		nodo_camara.global_position -= Vector2(686,0)
"""--------------------------------------------------------"""

""" PUNTUACIONES -----------------------------------------------------"""
func _on_puntuaciones_pressed() -> void:
	tabla_puntos.visible = not tabla_puntos.visible
	tabla_puntos.mostrar_tabla(nivel_actual)
"""--------------------------------------------------------"""

""" ACCESO A NIVELES -----------------------------------------------------"""
func _bloquear_nivel(btn_nivel:Button):
	if int(btn_nivel.text) < InfoPartida.nueva_partida:
		btn_nivel.disabled = true
		
func _establecer_niveles_bloqueado(nivel_max_desbloqueado: int):
	var ruta = ""
	var candado = ""
	for i in range(nivel_max_desbloqueado+1, NIVEL_MAX_CREADO+1):
		ruta = "niveles/nivel"+str(i)+"/isla/nivel_n"
		candado = "niveles/nivel"+str(i)+"/isla/candado"
		get_node(ruta).disabled = true
		get_node(candado).visible = true
