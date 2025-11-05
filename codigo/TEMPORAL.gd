extends HBoxContainer
@onready var button: Button = $Button
@onready var temp: Node2D = $"../temp"

var origin : Vector2
var end :=  Vector2(3140,377)
var nivel:= 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button.grab_focus()
	origin = temp.global_position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#_move_button()
	_move_camera()
	#print(temp.global_position)
	#print(nivel)
	pass

func _move_camera()->void:
	if temp.global_position == origin:
		nivel=1
	
	if Input.is_action_just_pressed("ui_right"):
		if temp.position == origin:
			temp.global_position += Vector2(1000,0) #mover camara
			nivel=2
		else:
			if not temp.global_position == end:
				temp.global_position += Vector2(700,0)
				nivel+=1
	if Input.is_action_just_pressed("ui_left"):
		if not temp.position == origin:
			temp.global_position += Vector2(-700,0)
			nivel -=1

func _move_button()->void:
	if Input.is_action_just_pressed("ui_right"):
		self.position -= Vector2(500,0)
	if Input.is_action_just_pressed("ui_left"):
		self.position += Vector2(500,0)
	pass
