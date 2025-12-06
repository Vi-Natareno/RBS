extends Node

var Arr_Conf = Data.db.select_rows("Conf_Nivel_Ritmo", "id= '" + str(InfoPartida.nivel_actual) + "'", ["*"])

var escala_velocidad = Arr_Conf[0]["escala_velocidad"]
var desfase_tiempo = Arr_Conf[0]["desfase_tiempo"]
var tiempo_espera = Arr_Conf[0]["tiempo_espera"]
var inicio_audio = Arr_Conf[0]["inicio_audio"]
var tolerancia_perfect = Arr_Conf[0]["tolerancia_perfect"]
var tolerancia_ok = Arr_Conf[0]["tolerancia_ok"]
var midi = Arr_Conf[0]["midi_src"]
var tiempo_finalizacion = Arr_Conf[0]["tiempo_finalizacion"]

var slayEvil_1 := preload("uid://x5yaxu0l63uk")
var empo_2 := preload("uid://cw5j1l6mes2pc")
var awesome_3 := preload("uid://dt8g5oiddhvom")
var leap_4 := preload("uid://w536o5ao2svs")
var stageTwo_5 = preload("uid://drpn0y3jhu0g")

#para ritmo
var audios := [slayEvil_1, empo_2, awesome_3, stageTwo_5, leap_4]

func get_audio( nivel: int):
	for i in audios:
		return audios[nivel-1]
	
func _ready() -> void:
#	print(midi)
	pass
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	if  InfoPartida.is_platform:
		Arr_Conf = Data.db.select_rows("Conf_Nivel_Ritmo", "id= '" + str(InfoPartida.nivel_actual) + "'", ["*"])
		escala_velocidad = Arr_Conf[0]["escala_velocidad"]
		desfase_tiempo = Arr_Conf[0]["desfase_tiempo"]
		tiempo_espera = Arr_Conf[0]["tiempo_espera"]
		inicio_audio = Arr_Conf[0]["inicio_audio"]
		tolerancia_perfect = Arr_Conf[0]["tolerancia_perfect"]
		tolerancia_ok = Arr_Conf[0]["tolerancia_ok"]
		midi = Arr_Conf[0]["midi_src"]
		tiempo_finalizacion = Arr_Conf[0]["tiempo_finalizacion"]
