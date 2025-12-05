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

func desbloquear_sig_nivel(nombre: String, nuevo_nivel: int):
	Data.db.update_rows("Partidas", "nombre = '" + nombre + "'", {"nivel": nuevo_nivel})
	pass
func actualizar_nivel_partida():
	#var data = Data.db.query("select nivel from Partidas where id = " + str(1))
	var data = Data.db.select_rows("Partidas","id = '" + str(InfoPartida.id_partida_actual) + "'", ["nivel"])
	return data[0]["nivel"]
	
