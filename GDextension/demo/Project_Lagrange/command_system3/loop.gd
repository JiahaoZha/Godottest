extends Control

@onready var input_1 = $Input1
@onready var linkup = $linkup
@onready var linkdown = $linkdown

var draging := false
var info := ""
var entered := false
var next_node = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	info = "loop " + input_1.text+ " times (\n"
	link_Signal()
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				draging = true
			else:
				draging = false
	if draging:
		if entered == true:
			position = get_global_mouse_position() - Vector2(100,0)


func _on_area_2d_mouse_entered():
	entered = true


func _on_area_2d_mouse_exited():
	entered = false

var link_flag_up := false
var link_flag_down := false

func _on_link_up_area_entered(area):
	if area.name == "functions":
		link_flag_up = true
		print("linked")


func _on_link_up_area_exited(area):
	if area.name == "functions":
		link_flag_up = false
		print("unlinked")


func _on_link_down_area_entered(area):
	if area.name == "functions":
		link_flag_down = true
		next_node = area.get_parent()
		print("find next one")


func _on_link_down_area_exited(area):
	if area.name == "functions":
		next_node = null
		link_flag_down = false
		print("clear next one")

func link_Signal():
	if link_flag_up == true:
		linkup.visible = true
	if link_flag_up == false:
		linkup.visible = false
	if link_flag_down == true:
		linkdown.visible = true
	if link_flag_down == false:
		linkdown.visible = false
