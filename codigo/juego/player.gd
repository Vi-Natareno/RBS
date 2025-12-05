extends CharacterBody2D

@onready var canelita: AnimatedSprite2D = $Animacion

const SPEED = 200.0
const JUMP_VELOCITY = -300.0
var vida = InfoPartida.vida_actual

func _physics_process(delta: float) -> void:
	#print(InfoPartida.vida_actual)
	if InfoPartida.is_platform:
		moverse(delta)

func moverse(delta:float):
	if not is_on_floor():
		velocity += get_gravity() * delta
	#jump
	if Input.is_action_pressed("jump") and is_on_floor(): 
		velocity.y = JUMP_VELOCITY
	if not is_on_floor():
		canelita.play("jump")
	#/jump
	var dir := Input.get_axis("izquierda", "derecha")
	if dir:
		canelita.play("running")
		velocity.x = dir* SPEED
		if dir > 0:
			canelita.flip_h = false
		elif dir < 0:
			canelita.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		canelita.play("idle")
	move_and_slide()
