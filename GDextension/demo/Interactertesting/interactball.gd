extends MeshInstance3D

@onready var controlpanel: Node2D = $Controlpanel
@onready var balltag: Label3D = $balltag
@onready var highlight: MeshInstance3D = $highlight
@onready var start_button: Button = $Start_button

var numbers = []
var start_action = false
var checkit:int = 0

func _on_area_3d_input_event(camera: Node, event: InputEvent, position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed == true:
			balltag.visible =! balltag.visible
			highlight.visible =! highlight.visible
			controlpanel.visible =! controlpanel.visible
			start_button.visible = controlpanel.visible

func _on_start_button_pressed() -> void:
	checkit = 0
	start_action = false
	var file_path = "res://Interactertesting/Interactpad/child_data.txt"
	var file = FileAccess.open(file_path, FileAccess.READ)
	if file:
		while not file.eof_reached():
			var line = file.get_line()
			var number = line.to_int()
			numbers.append(number)
	start_action = true
			
func _process(delta: float) -> void:
	if start_action == true:
		if numbers[checkit] == 1:
			var tween = create_tween()
			tween.tween_property(self,"global_position",global_position+Vector3(2,0,0),1)
		if numbers[checkit] == 0:
			var tween = create_tween()
			tween.tween_property(self,"global_position",global_position+Vector3(-2,0,0),1)
	

	


func _on_timer_timeout() -> void:
	if checkit < numbers.size()-1:
		checkit += 1
		
