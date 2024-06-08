extends Button

@export var reference_path : String
@export var start_focused: bool = false

func _ready() -> void:
	if start_focused:
		grab_focus()

	self.mouse_entered.connect(_on_button_mouse_entered)
	self.pressed.connect(_on_button_pressed)


func _on_button_mouse_entered():
	grab_focus()
	
func _on_button_pressed():
	if reference_path != "" :
		get_tree().change_scene_to_file(reference_path)
	else:
		get_tree().quit()
