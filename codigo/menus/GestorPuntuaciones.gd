extends Node

func get_puntuacion(nivel_actual:int)->Array:
	var puntuaciones = Data.db.select_rows("Ranking", "nivel = '" + str(nivel_actual) + "'", ["nombre", "puntuacion"])
	#puntuaciones = [{},{},{}] Array con nombre y puntuacion
	return puntuaciones 
func guardar_puntuacion(nombre:String,nivel:int,puntuacion:int):
	var top = _verificar_actualizacion(nivel,puntuacion)
	if not top == 0:
		#Data.db.update_rows("Ranking", "top = '" + str(top) + "'", {"nombre": nombre,"puntuacion": str(puntuacion)})
		Data.db.query("update Ranking set nombre = '" +nombre+ "', puntuacion = "+str(puntuacion)+" where nivel = "+str(nivel)+" AND top = " + str(top))

func _verificar_actualizacion(nivel: int,puntuacion:int)->int:
	var top = Data.db.select_rows("Ranking", "nivel = '" + str(nivel) + "'", ["puntuacion"])
	var top1 = int(top[0]["puntuacion"])
	var top2 = int(top[1]["puntuacion"])
	var top3 = int(top[2]["puntuacion"])
	if puntuacion > top1:
		return 1
	elif puntuacion > top2:
		return 2
	elif puntuacion > top3:
		return 3
	return 0
	
func _ready() -> void:
	pass
