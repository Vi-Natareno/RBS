extends Area2D
#META ----------------------
@onready var timer_meta: Timer = Timer.new()

func _ready() -> void:
	add_child(timer_meta)
	timer_meta.wait_time = 2
	timer_meta.one_shot = true
	timer_meta.timeout.connect(_on_timer_meta_timeout)

func _on_timer_meta_timeout():
	InfoPartida.vida_final_plataforma = InfoPartida.vida_actual
	get_tree().change_scene_to_file("res://RBS/escenas/juego/ritmo/ritmo.tscn")

@warning_ignore("unused_parameter")
func _on_body_entered(body: Node2D) -> void:
	InfoPartida.last_plat_position = InfoPartida.last_positions[InfoPartida.nivel_actual-1]
	$"../HUD/carg1".show()
	$"../HUD/carglab".show()
	InfoPartida.is_platform = false
	timer_meta.start()
	pass # Replace with function body.
