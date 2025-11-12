extends Control

@onready var nodo_camara: Node2D = $Nodo_camara
@onready var tabla_puntos: TextureRect = $CanvasLayer/TablaPuntos

var nivel_actual:int = 1
var camara_pos_origen = Vector2(0,0)
var camara_pos_limite = Vector2(2744,0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CanvasLayer/limite_izquierdo.modulate = Color(1,1,1,0.35)
	$CanvasLayer/limite_derecho.modulate = Color(1,1,1,0.35)
	nivel_actual = 1
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#print(nivel_actual)
#	pass

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

func _on_puntuaciones_pressed() -> void:
	tabla_puntos.show()
	tabla_puntos.mostrar_tabla(nivel_actual)

func _on_regresar_pressed() -> void:
	get_tree().change_scene_to_file("res://RBS/escenas/menus/menu_carga.tscn")
