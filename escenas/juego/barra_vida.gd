extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func actualizar_barra_vida():
	var residuo = InfoPartida.vida_actual % 4
	var idx_corazon = get_child_count()
	var corazon_actual = get_child(idx_corazon-1)
	corazon_actual.frame = residuo
	pass
	
func desaparecer_corazon():
	var idx_corazon = get_child_count()
	var corazon_actual = get_child(idx_corazon-1)
	if idx_corazon > 0:
		corazon_actual.queue_free()
