extends Control

var dataBase: SQLite
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	dataBase = SQLite.new()
	dataBase.path = "res://data.db"
	dataBase.open_db()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_crear_tabla_pressed() -> void:
	pass # Replace with function body.


func _on_insertar_datos_pressed() -> void:
	pass # Replace with function body.


func _on_seleccionar_datos_pressed() -> void:
	pass # Replace with function body.


func _on_actualizar_datos_pressed() -> void:
	pass # Replace with function body.


func _on_eliminar_datos_pressed() -> void:
	pass # Replace with function body.
