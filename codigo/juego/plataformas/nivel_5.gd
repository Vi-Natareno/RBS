extends Node2D
@onready var menu_pausa: Control = $HUD/MenuPausa
const PLATF_SLIME = preload("uid://c662tpqtuh2oi")
const BALA = preload("uid://dadrmyf6dksby")
@onready var node: Node2D = $enemigos/node
@onready var node_gran_slime: Node2D = $enemigos/node_gran_slime
@onready var green_slime: AnimatedSprite2D = $enemigos/green_slime
@onready var green_slime_2: AnimatedSprite2D = $enemigos/green_slime2
@onready var green_slime_4: AnimatedSprite2D = $enemigos/green_slime4
@onready var green_slime_6: AnimatedSprite2D = $enemigos/green_slime6
@onready var timer1: Timer = Timer.new()
var t_espera = 0
var t_espera_b = 0
var delta_sum = 0
#posicion player
@onready var canelita: CharacterBody2D = $Player
@onready var camera_2d: Camera2D = $Player/Camera2D
#barra vida
@onready var barra_vida: Node2D = $HUD/barra_vida
var corazones:int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	InfoPartida.is_platform = true
	_actualizar_corazones()
	$HUD.show()
	camera_2d.position_smoothing_enabled = false
	if InfoPartida.perder_en_ritmo:
		canelita.position = InfoPartida.last_plat_position
	add_child(timer1)
	timer1.wait_time = 1
	timer1.one_shot = true
	green_slime.direccion = 1
	green_slime_2.direccion = 1
	green_slime_4.direccion = 1
	green_slime_6.direccion = 1
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	camera_2d.position_smoothing_enabled = true
	delta_sum += delta
	print(node_gran_slime.position.x)
	if not node.position.x >= 2500:
		if delta_sum >=2:
			node.position.x += 180*delta
			node_gran_slime.position.x += 330*delta
			mover_enemigo1(green_slime,180,delta)
			mover_enemigo1(green_slime_2,180,delta)
			mover_enemigo1(green_slime_4,180,delta)
			if not node_gran_slime.position.x >= 4000:
				mover_enemigo2(green_slime_6,330,delta)
		else:
			node_gran_slime.position.x += 100 *delta
			mover_enemigo1(green_slime,100,delta)
			mover_enemigo1(green_slime_2,100,delta)
			mover_enemigo1(green_slime_4,100,delta)
			mover_enemigo2(green_slime_6,100,delta)
	else:
		timer1.stop()
		#green_slime.hide()
		#green_slime_2.hide()
		#green_slime_4.hide()
		#green_slime_6.hide()
		pass


func mover_enemigo1(enemigo,velocidad: int,delta: float):
		enemigo.mover_horizontal(velocidad, delta)
		
func mover_enemigo2(enemigo,velocidad: int,delta: float):
	if timer1.is_stopped():
		t_espera_b += delta
		if t_espera_b >= 0.5:
			timer1.start()
	else:
		enemigo.mover_horizontal(velocidad, delta)
		t_espera_b = 0	
			
func _actualizar_corazones():
	var residuo = InfoPartida.vida_actual % 4
	corazones = int(ceil(float(InfoPartida.vida_actual)/4))
	InfoPartida.corazones_reales = int(ceil(float(InfoPartida.vida_actual)/4))
	for i in range (corazones,barra_vida.get_child_count()):
		barra_vida.get_child(i).queue_free()
	barra_vida.get_child(corazones-1).frame = residuo
