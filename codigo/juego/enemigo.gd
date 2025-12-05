extends AnimatedSprite2D
const BALA = preload("uid://dadrmyf6dksby")

@onready var collsn_der: RayCast2D = $collsn_der
@onready var collsn_izq: RayCast2D = $collsn_izq
@onready var timer: Timer = $Timer
#salto
var direccion: int = -1
var velocidad:int = 70
var t_espera =0
#bala
var inter_disparo := 1
var t_transcurrido := 0.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	t_transcurrido += delta
	#"""
	if t_transcurrido >= inter_disparo:
		t_transcurrido = 0
		var bala = BALA.instantiate()
		bala.position = position
		get_parent().add_child(bala)
	#"""
	"""
	if timer.is_stopped():
		timer.wait_time = 1
		t_espera += delta
		#mover_horizontal(velocidad*2, delta)
		if t_espera >= 0.4:
			timer.start()
	else:
		mover_horizontal(velocidad*2, delta)
		t_espera = 0
	"""
	pass
	
	
func mover_horizontal(vel:int, delta: float):
	position.x += vel * delta * direccion
	if collsn_der.is_colliding() :
		direccion = -1
		self.flip_h = true
	if collsn_izq.is_colliding():
		direccion = 1
		self.flip_h = false
		

	
"""
func movimiento_paso():
	if timer.is_stopped():
		timer.wait_time = 1
		t_espera += delta
		#mover_horizontal(velocidad*2, delta)
		if t_espera >= 0.4:
			timer.start()
	else:
		mover_horizontal(velocidad*2, delta)
		t_espera = 0	
	#timer 0.4, espera 0.4, pasos
	"""
