extends Control
var puntos:int = 0
var puntos_graficados = 0
var puntos_finales: int = 0
var pf_graficados: int = 0
var vida = 0
var corazon = 0
var timer := Timer.new()
var top = 0
@onready var label_puntos: Label = $"Pantalla/panel_principal/Hbox paneles/panel_puntos/vBox puntos/GridContainer/puntos_ritmo"
@onready var pts_finales: Label = $pts_finales
@onready var continuar: Button = $Pantalla/continuar
@onready var barra_vida: Node2D = $Pantalla/barra_vida
@onready var gestor_puntuaciones: Node = $GestorPuntuaciones
@onready var gestor_partidas: Node = $GestorPartidas

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	puntos = Puntuador.puntos
	puntos_finales = puntos * InfoPartida.vida_actual
	continuar.disabled = true
	for i in barra_vida.get_children():
		i.frame = 4
	add_child(timer)
	timer.wait_time = 0.05
	timer.one_shot = true
	timer.start()
	guardar_datos_partida()
	

func _process(delta: float) -> void:
	if puntos_graficados < puntos:
		actualizar_puntos()
		label_puntos.text = str(puntos_graficados)
	if pf_graficados < puntos_finales:
		actualizar_puntos_finales()
		pts_finales.text = str(pf_graficados)
	else:
		continuar.disabled = false
	actualizar_corazones()
	

func actualizar_corazones():
	var residuo = 0
	if timer.is_stopped():
		if vida < InfoPartida.vida_actual:
			vida += 1
			residuo = vida % 4
			barra_vida.get_child(corazon).frame = residuo
			if residuo == 0:
				corazon+=1
			timer.start()
	
func actualizar_puntos() -> void:
	var paso = max(1, puntos * 0.005)
	if puntos_graficados < puntos:
		puntos_graficados += int(paso)

func actualizar_puntos_finales():
	var paso = max(1, puntos * 0.1)
	if pf_graficados < puntos_finales:
		pf_graficados += int(paso)

func _on_continuar_pressed() -> void:
	get_tree().change_scene_to_file("res://RBS/escenas/menus/menu_niveles.tscn")

func guardar_datos_partida():
	gestor_puntuaciones.guardar_puntuacion(InfoPartida.partida_actual["nombre"], InfoPartida.nivel_actual, puntos_finales)
	# guardar_puntuacion(nombre:String,nivel:int,puntuacion:int):
	print(InfoPartida.partida_actual["nivel"])
	if InfoPartida.partida_actual["nivel"] == InfoPartida.nivel_actual and InfoPartida.nivel_actual < 5:
		gestor_partidas.desbloquear_sig_nivel(InfoPartida.partida_actual["nombre"], InfoPartida.partida_actual["nivel"]+1)
		InfoPartida.partida_actual["nivel"] = gestor_partidas.actualizar_nivel_partida()
	print(InfoPartida.partida_actual["nivel"])
	#desbloquear_sig_nivel(nombre: String, nuevo_nivel: int):
	pass
