extends Node

var Arr_Conf = Data.db.select_rows("Conf_Nivel_Ritmo", "id= '" + str(InfoPartida.nivel_actual) + "'", ["*"])

var escala_velocidad = Arr_Conf[0]["escala_velocidad"]
var desfase_tiempo = Arr_Conf[0]["desfase_tiempo"]
var tiempo_espera = Arr_Conf[0]["tiempo_espera"]
var inicio_audio = Arr_Conf[0]["inicio_audio"]
var tolerancia_perfect = Arr_Conf[0]["tolerancia_perfect"]
var tolerancia_ok = Arr_Conf[0]["tolerancia_ok"]
var midi = Arr_Conf[0]["midi_src"]

var empo_1 := preload("uid://cw5j1l6mes2pc")
var leap_2 := preload("uid://w536o5ao2svs")
var awesome_3 := preload("uid://dt8g5oiddhvom")
var stageTwo_4 := preload("uid://bfi366ck7tb32")
var slayEvil_5 := preload("uid://x5yaxu0l63uk")

var audios := [empo_1, leap_2, awesome_3, stageTwo_4, slayEvil_5]

func get_audio( nivel: int):
	for i in audios:
		return audios[nivel-1]
	
func _ready() -> void:
#	print(midi)
	pass
