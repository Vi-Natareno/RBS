extends Control


func _process(delta: float) -> void:
	pausar()

func _on_reanudar_2_pressed() -> void:
	InfoPartida.is_platform = true
	$".".hide()
	pass # Replace with function body.

func _on_regresar_pressed() -> void:
	InfoPartida.vida_final_plataforma = 0
	InfoPartida.vida_actual = 32
	get_tree().change_scene_to_file("res://RBS/escenas/menus/menu_niveles.tscn")
	pass # Replace with function body.

func pausar():
	if InfoPartida.is_platform:
		if Input.is_action_just_pressed("pausa"):
			InfoPartida.is_platform = false
			$".".show()
