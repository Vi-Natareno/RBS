extends Node2D

func _ready() -> void:
	var destino = position - Vector2(-5,10)
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate", Color(1,1,1,0.0), 0.5).set_trans(Tween.TRANS_QUAD)
	tween.parallel().tween_property(self, "position", destino, 0.5)
	tween.tween_callback(queue_free)

func cambiar_texto(texto):
	$Label.text = texto
