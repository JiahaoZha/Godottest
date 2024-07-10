extends StaticBody2D

@export var mark: PackedScene

var is_sth_inside := false
var  C_number:int = 0
var showtime := false
var dragable : bool
@onready var check_button = $CheckButton


func _process(delta) -> void:
	
	if C_number == 1 and showtime == true:
		var show_icon = mark.instantiate()
		add_child(show_icon)
		showtime = false
	if Input.is_action_pressed("Mouse_click") and dragable == true:
			global_position = get_global_mouse_position()




func _on_check_button_toggled(toggled_on):
	dragable = check_button.button_pressed
	print(dragable)
