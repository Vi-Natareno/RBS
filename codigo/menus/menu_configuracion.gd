extends Control
@onready var h_slider_efecto: HSlider = $MenuConfiguracion/MarginContainer/VBoxContainer/HSlider_efecto
@onready var h_slider_musica: HSlider = $MenuConfiguracion/MarginContainer/VBoxContainer/HSlider_musica
@onready var musica_sample: AudioStreamPlayer2D = $EjemplosDeAudio/musica
@onready var efecto_sample: AudioStreamPlayer2D = $EjemplosDeAudio/efecto
var cambio = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	h_slider_efecto.value = db_to_linear(AudioServer.get_bus_volume_db(1))
	h_slider_musica.value = db_to_linear(AudioServer.get_bus_volume_db(2))

func reproducir_audio(conf_visible: bool = true):
	if conf_visible:
		musica_sample.play()
	else:
		musica_sample.stop()

func _on_aplicar_cambios_pressed() -> void:
	"""guardar en base de datos"""
	pass # Replace with function body.

func _on_h_slider_efecto_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(2, linear_to_db(h_slider_efecto.value))
	
func _on_h_slider_musica_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(1, linear_to_db(h_slider_musica.value))

func _on_h_slider_efecto_drag_ended(value_changed: bool) -> void:
	efecto_sample.play()
