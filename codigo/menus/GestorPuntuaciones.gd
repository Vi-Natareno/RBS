extends Node

func get_puntuacion(nivel_actual:int)->Array:
	var puntuaciones = Data.db.select_rows("Ranking", "nivel = '" + str(nivel_actual) + "'", ["nombre", "puntuacion"])
	#puntuaciones = [{},{},{}] Array con nombre y puntuacion
	return puntuaciones 
