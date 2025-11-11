extends Node

var db: SQLite

func _ready() -> void:
	_cargar_archivo()
	
func _process(delta: float) -> void:
	pass

func _cargar_archivo():
	db = SQLite.new()
	db.path = "res://data.db"
	db.open_db()
	
func verificar_actualizacion_ranking(nivel: String, puntuacion:int):
	#verificar actualizacion de ranking
	pass

func actualizar_ranking():
	pass
	
