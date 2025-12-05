extends Node
var velocidad = 70
var delta_sum = 0
var t_destruccion = 1.5
@onready var bala: Area2D = $".."

func _process(delta: float) -> void:
	delta_sum += delta
	bala.position.x -= delta * velocidad 
	if bala.position.x > 1280 or bala.position.x < 0:
		bala.queue_free()
	if delta_sum >= t_destruccion:
		delta_sum = 0
		bala.queue_free()
