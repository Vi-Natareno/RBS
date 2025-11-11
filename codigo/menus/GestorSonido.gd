extends Node
var sonidos = Data.db.select_rows("AudioConfig","efecto >= 0", ["efecto","musica"])
#var puntuaciones = gen_db.select_rows("Ranking", "nivel>0", ["nombre", "puntuacion"])

func actualizar_conf_sonido(efecto: float, musica:float):
	Data.db.update_rows("AudioConfig", "id=1", {"efecto": efecto,"musica": musica})
	
func cargar_conf_sonido():
	AudioServer.set_bus_volume_db(1, linear_to_db(get_efecto()))
	AudioServer.set_bus_volume_db(2, linear_to_db(get_musica()))

func get_efecto()->float:
	return sonidos[0]["efecto"]

func get_musica()->float:
	return sonidos[0]["musica"]
