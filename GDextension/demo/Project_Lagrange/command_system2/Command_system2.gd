extends Control

var draging := false


@onready var command_system_2 = $"."
@onready var option_button = $OptionButton
@onready var confirm = $Confirm
@onready var assign_func = $assign_func
@onready var label = $Label
@onready var container = $Container
@onready var add_line = $add_line
@onready var second_input = $second_input
@onready var plus = $plus
@onready var if_button = $if_button
@onready var if_label = $if_button/if_label


var subscene: PackedScene = preload("res://Project_Lagrange/command_system2/sub_window.tscn")

var basic_info : String = ""
var num := 1

		
func _ready():
	all_invisible()
	add_option()
	
	
	
func add_option() ->void:
	option_button.add_item("null")
	option_button.add_item("+")
	option_button.add_item("-")
	option_button.add_item("x")
	option_button.add_item("/")

	option_button.add_item("loop")
	option_button.add_item("<")
	option_button.add_item(">")
	option_button.add_item("=")
	
	option_button.add_item("Velocity")
	option_button.add_item("mass")

func _on_option_button_item_selected(index):
	match index:
		0:
			null_do ()
			basic_info = "null"
		1:
			plus_do ()
		2:
			Subtraction_do()
		3:
			times_do()
		4:
			division_do()
		5:
			loop_do()
		6:
			smaller_do()
		7:
			bigger_do()
		8:
			equall_do()
		9:
			velocity_assgin_do()
		10:
			mass_assgin_do()
			

func null_do ():
	all_invisible()
	option_button.visible = true
	check ()
	
func plus_do ():
	all_invisible()
	plus.text = "+"
	second_input.visible = true
	label.visible = false
	plus.visible = true
	assign_func.visible = true
	container.visible = false
	confirm.visible = assign_func.visible
	check ()
	

func Subtraction_do():
	all_invisible()
	confirm.visible = true
	assign_func.visible = true
	plus.text = "-"
	plus.visible = true
	second_input.visible = true
	check ()
	
func times_do():
	all_invisible()
	confirm.visible = true
	assign_func.visible = true
	plus.text = "x"
	plus.visible = true
	second_input.visible = true
	check ()
	
func division_do():
	all_invisible()
	confirm.visible = true
	assign_func.visible = true
	plus.text = "/"
	plus.visible = true
	second_input.visible = true
	check ()	
	

func smaller_do():
	all_invisible()
	confirm.visible = true
	assign_func.visible = true
	plus.text = "<"
	plus.visible = true
	second_input.visible = true
	check ()

func bigger_do():
	all_invisible()
	confirm.visible = true
	assign_func.visible = true
	plus.text = ">"
	plus.visible = true
	second_input.visible = true
	check ()

func equall_do():
	all_invisible()
	confirm.visible = true
	assign_func.visible = true
	plus.text = "="
	plus.visible = true
	second_input.visible = true
	check ()
	
var current_instance = null

func loop_do():
	label.text = "loop"
	label.visible = true
	add_line.visible = true
	assign_func.visible = true
	plus.text = "times"
	plus.visible = true
	second_input.visible = false
	confirm.visible = true
	container.visible = true
	check ()
	sub_window ()
	
	
func sub_window ():
	current_instance = subscene.instantiate()
	container.add_child(current_instance)

	
func check ():
	if current_instance:
		container.remove_child(current_instance)
		current_instance.queue_free()
		current_instance = null


func _on_add_line_pressed():
	sub_window ()

func all_invisible():
	option_button.visible = true
	assign_func.visible = false
	second_input.visible = false
	plus.visible = false
	label.visible = false
	confirm.visible = false
	add_line.visible = false
	container.visible = false
	
	
func velocity_assgin_do():
	all_invisible()
	label.text = "Velocity = "
	label.visible = true
	second_input.visible = true
	confirm.visible = true
	
func mass_assgin_do():
	all_invisible()
	label.text = "Mass = "
	label.visible = true
	second_input.visible = true
	confirm.visible = true
	
func info_is():
	if option_button.get_selected_id() == 1:
		basic_info += assign_func.text + " + " + second_input.text + "\n"
	if option_button.get_selected_id() == 2:
		basic_info += assign_func.text + " - " + second_input.text + "\n"
	if option_button.get_selected_id() == 3:
		basic_info += assign_func.text + " x " + second_input.text + "\n"
	if option_button.get_selected_id() == 4:
		basic_info += assign_func.text + " / " + second_input.text + "\n"
	if option_button.get_selected_id() == 5:
		basic_info += "loop " + assign_func.text + " times" + "\n"
	if option_button.get_selected_id() == 6:
		basic_info += assign_func.text + " < " + second_input.text + "\n"
	if option_button.get_selected_id() == 7:
		basic_info += assign_func.text + " > " + second_input.text + "\n"
	if option_button.get_selected_id() == 8:
		basic_info += "Velocity = " + second_input.text + "\n"
	if option_button.get_selected_id() == 9:
		basic_info += "Mass = " + " = " + second_input.text + "\n"
	if current_instance:
		for i in container.get_children():
			basic_info += i.sub_info

func _on_confirm_pressed():
	info_is()
	if if_button.button_pressed == true:
		basic_info = "if " + basic_info
	confirm.disabled = true
	print(basic_info)



func _on_if_button_toggled(toggled_on):
	if if_button.button_pressed == true:
		if_label.visible = true
	else:
		if_label.visible = false

var entered := false

func _on_area_2d_mouse_entered():
	entered = true
	
	
func  _input(event):
	if entered == true:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT:
				if event.is_pressed():
					draging = true
				else:
					draging = false
					entered = false
					
		if draging:
			position = get_global_mouse_position()



