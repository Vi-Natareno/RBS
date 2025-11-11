extends Control
@onready var h_slider_efecto: HSlider = $MenuConfiguracion/MarginContainer/VBoxContainer/HSlider_efecto
@onready var h_slider_musica: HSlider = $MenuConfiguracion/MarginContainer/VBoxContainer/HSlider_musica
@onready var musica_sample: AudioStreamPlayer2D = $EjemplosDeAudio/musica
@onready var efecto_sample: AudioStreamPlayer2D = $EjemplosDeAudio/efecto
@onready var gestor_sonido: Node = $GestorSonido
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gestor_sonido.cargar_conf_sonido()
	_inicializar_sliders()
	pass

func reproducir_audio(conf_visible: bool = true):
	if conf_visible:
		musica_sample.play()
	else:
		musica_sample.stop()

func _inicializar_sliders():
	h_slider_efecto.value = gestor_sonido.get_efecto()
	h_slider_musica.value = gestor_sonido.get_musica()

func _on_h_slider_efecto_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(2, linear_to_db(h_slider_efecto.value))
	
func _on_h_slider_musica_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(1, linear_to_db(h_slider_musica.value))

func _on_h_slider_efecto_drag_ended(value_changed: bool) -> void:
	efecto_sample.play()

func _on_exit_pop_panel_pressed() -> void:
	get_parent().hide()
	$".".hide()
	reproducir_audio(false)
	gestor_sonido.actualizar_conf_sonido(h_slider_efecto.value, h_slider_musica.value)
	pass # Replace with function body.
