extends Control

@onready var assign_func = $assign_func
@onready var confirm = $confirm
@onready var container_1 = $Container1
@onready var if_label = $If_Label
@onready var option_button = $OptionButton
@onready var add_line = $add_line
@onready var second_input = $assign_func/second_input
@onready var plus = $assign_func/plus

var sub_info : String = ""
var subscene2 : PackedScene = preload("res://Project_Lagrange/command_system2/sub_window2.tscn")


func _ready():
	all_invisible()
	add_option()
	
	
func add_option() ->void:
	option_button.add_item("null")
	option_button.add_item("+")
	option_button.add_item("-")
	option_button.add_item("x")
	option_button.add_item("/")
	option_button.add_item("if")
	option_button.add_item("loop")

func _on_option_button_item_selected(index):
	match index:
		0:
			null_do ()
			sub_info = "null"
		1:
			plus_do ()
		2:
			Subtraction_do()
		3:
			times_do()
		4:
			division_do()
		5:
			if_do ()
		6:
			loop_do()
	

func null_do ():
	assign_func.visible = false
	confirm.visible = false
	add_line.visible = false
	if_label.visible = false
	
func plus_do ():
	assign_func.visible = true
	confirm.visible = true
	if_label.visible = false
	sub_info += assign_func.text
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
	
func if_do ():
	if_label.text = "if"
	second_input.visible = false
	plus.visible = false
	add_line.visible = true
	if_label.visible = true
	assign_func.visible = true
	container_1.visible = true
	confirm.visible = assign_func.visible
	check ()
	sub_window2 ()
	
func loop_do():
	if_label.text = "loop"
	if_label.visible = true
	add_line.visible = true
	assign_func.visible = true
	plus.text = "times"
	plus.visible = true
	second_input.visible = false
	confirm.visible = true
	container_1.visible = true
	check ()
	sub_window2 ()
	

	
var current_instance = null

func sub_window2 ():
	current_instance = subscene2.instantiate()
	container_1.add_child(current_instance)

func check ():
	if current_instance:
		container_1.remove_child(current_instance)
		current_instance.queue_free()
		current_instance = null

	
func _on_add_line_pressed():
	sub_window2 ()

func all_invisible():
	option_button.visible = true
	assign_func.visible = false
	if_label.visible = false
	confirm.visible = false
	add_line.visible = false
	container_1.visible = false

func info_is():
	if option_button.get_selected_id() == 1:
		sub_info =" " + sub_info + assign_func.text + " + " + second_input.text + "\n"
	if option_button.get_selected_id() == 2:
		sub_info =" " + sub_info + assign_func.text + " - " + second_input.text + "\n"
	if option_button.get_selected_id() == 3:
		sub_info =" " + sub_info + assign_func.text + " x " + second_input.text + "\n"
	if option_button.get_selected_id() == 4:
		sub_info =" " + sub_info + assign_func.text + " / " + second_input.text + "\n"
	if option_button.get_selected_id() == 5:
		sub_info =" " + sub_info + "if " + assign_func.text + "\n"
	if option_button.get_selected_id() == 6:
		sub_info =" " + sub_info + "loop " + assign_func.text + " times" + "\n"
	if current_instance:
		for i in container_1.get_children():
			sub_info += i.sub_info1

func _on_confirm_pressed():
	info_is()
