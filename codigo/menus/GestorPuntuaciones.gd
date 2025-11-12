extends Node
#var puntuaciones = Data.db.select_rows("Ranking","nivel>0", ["efecto","musica"])

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_puntuacion(1)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func get_puntuacion(nivel_actual:int)->Array:
	var puntuaciones = Data.db.select_rows("Ranking", "nivel = '" + str(nivel_actual) + "'", ["nombre", "puntuacion"])
	#puntuaciones = [{},{},{}] Array con nombre y puntuacion
	return puntuaciones 
