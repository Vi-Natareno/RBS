extends Area2D
var timer := Timer.new()
var efecto := AudioStreamPlayerADSR.new()
const HURT = preload("uid://dsje4ej475u2l")
@onready var barra_vida = get_node("/root/Juego/HUD/barra_vida")
#a reemplazar
func _ready() -> void:
	add_child(timer)
	add_child(efecto)
	efecto.stream = HURT
	timer.wait_time = 0.8
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)	

func _on_body_entered(body: Node2D) -> void:
	if body == get_node("/root/Juego/Player"):
		if InfoPartida.vida_actual > 1:
			InfoPartida.vida_actual -= 1
			if InfoPartida.vida_actual % 4 == 0:
				barra_vida.desaparecer_corazon()
			barra_vida.actualizar_barra_vida()
		else: 
			body.get_node("hitbox").queue_free()
			barra_vida.desaparecer_corazon()
			timer.start()
			Engine.time_scale = 0.5
		efecto.play()

func _on_timer_timeout():
	Engine.time_scale = 1
	InfoPartida.vida_actual = 32
	get_tree().reload_current_scene()
	pass
