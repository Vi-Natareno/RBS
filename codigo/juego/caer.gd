extends Area2D
var timer := Timer.new()
var efecto := AudioStreamPlayer.new()
const HURT = preload("uid://dsje4ej475u2l")

func _ready() -> void:
	add_child(timer)
	add_child(efecto)
	efecto.stream = HURT
	timer.wait_time = 0.8
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)
	

func _on_body_entered(body: Node2D) -> void:
	if not InfoPartida.perder_en_ritmo:
		InfoPartida.vida_actual = 32
	body.get_node("hitbox").queue_free()
	timer.start()
	efecto.play()
	Engine.time_scale = 0.5
	
func _on_timer_timeout():
	Engine.time_scale = 1
	get_tree().reload_current_scene()
	pass
