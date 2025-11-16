extends Node

#func _ready() -> void:
#	print(get_nombres())

func get_nombres()->Array:
	var nombres = Data.db.select_rows("Partidas","id > 0", ["nombre"])
	return nombres

func get_partida(no_partida:int)->Dictionary:
	var partida = Data.db.select_rows("Partidas","id = '" + str(no_partida) + "'", ["nombre","nivel"])
	return partida[0]

func nueva_partida(nombre: String, id: int): # func actualizar_archivo_partidas
	Data.db.update_rows("Partidas", "id = '" + str(id) + "'", {"nombre": nombre,"nivel": 1})
	pass
