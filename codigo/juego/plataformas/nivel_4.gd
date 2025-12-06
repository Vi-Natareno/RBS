extends Node2D
@onready var menu_pausa: Control = $HUD/MenuPausa
const PLATF_SLIME = preload("uid://c662tpqtuh2oi")
const BALA = preload("uid://dadrmyf6dksby")
@onready var slime_bala: AnimatedSprite2D = $enemigos/green_slime3
@onready var slime_1: AnimatedSprite2D = $enemigos/green_slime
@onready var n_1: AnimatedSprite2D = $enemigos/n1
@onready var n_2: AnimatedSprite2D = $enemigos/n2
@onready var n_3: AnimatedSprite2D = $enemigos/n3
@onready var n_4: AnimatedSprite2D = $enemigos/n4
@onready var n_5: AnimatedSprite2D = $enemigos/n5
@onready var n_6: AnimatedSprite2D = $enemigos/n6
@onready var puente: AnimatedSprite2D = $enemigos/puente
@onready var bala_1: AnimatedSprite2D = $enemigos/bala1

@onready var timer1: Timer = Timer.new()
@onready var timer_bala1: Timer = Timer.new()
@onready var timer_bala2: Timer = Timer.new()
var t_espera = 0
var t_espera_b = 0
var t_espera_bala_rapida = 0
var t_espera_bala_2 = 0
var t_transcurrido = 0
var t_transcurrido_2 = 0
var inter_disparo := 0.5
var inter_disparo_rapido := 0.4
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
	add_child(timer_bala1)
	add_child(timer_bala2)
	timer1.wait_time = 0.1
	timer_bala1.wait_time = 5 #menos seguido
	timer_bala2.wait_time = 2 #menos seguido
	timer1.one_shot = true
	timer_bala1.one_shot = true
	timer_bala2.one_shot = true
	timer1.start()
	timer_bala1.start()
	timer_bala2.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	camera_2d.position_smoothing_enabled = true
	t_transcurrido += delta
	t_transcurrido_2 += delta
	mover_enemigo1(n_1,80,delta)
	mover_enemigo1(n_2,80,delta)
	mover_enemigo1(n_3,120,delta)
	mover_enemigo1(puente,120,delta)
	mover_enemigo2(n_4,80,delta)
	mover_enemigo2(n_5,80,delta)
	mover_enemigo2(n_6,80,delta)
	disparar_balas2(bala_1,70,delta)
	pass


func disparar_balas2(enemigo, velocidad: int, delta: float):
	if timer_bala2.is_stopped():
		t_espera_bala_2 += delta
		if t_espera_bala_2 >= 1: #tiempo que va a esperar a salir de este if4
			t_espera_bala_2 = 0
			timer_bala2.start()
	else:
		if t_transcurrido_2 >= inter_disparo:
			t_espera_bala_2 = 0
			var bala = BALA.instantiate()
			bala.get_node("bala").t_destruccion = 10
			bala.position = enemigo.position + Vector2(0,-4) 
			bala.get_node("bala").velocidad = velocidad * enemigo.direccion
			enemigo.get_parent().add_child(bala)
			t_transcurrido_2 = 0	
		
func mover_enemigo1(enemigo,velocidad: int,delta: float):
	if not (enemigo.position.x <= 455 and enemigo.position.y > 0):
		if timer1.is_stopped():
			timer1.wait_time = 5
			t_espera += delta
			enemigo.mover_horizontal(velocidad*2, delta)
			if t_espera >= 2:
				timer1.start()
		else:
			enemigo.mover_horizontal(velocidad, delta)
			t_espera = 0
	else:
		enemigo.position = Vector2(862,enemigo.position.y)
	#timer 0.4, espera 0.4, pasos	
func mover_enemigo2(enemigo,velocidad: int,delta: float):
	if timer1.is_stopped():
		timer1.wait_time = 0.5
		t_espera_b += delta
		if t_espera_b >= 4:
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
