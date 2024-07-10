extends Control

@onready var confirm = $Confirm

@onready var assign_func = $assign_func
@onready var option_button = $OptionButton
@onready var second_input = $assign_func/second_input
@onready var plus = $assign_func/plus



var sub_info1 := ""


func _ready():
	all_invisible()
	add_option()
	
	
	
func add_option() ->void:
	option_button.add_item("null")
	option_button.add_item("+")
	option_button.add_item("-")
	option_button.add_item("x")
	option_button.add_item("/")
	
	
func _on_option_button_item_selected(index):
	match index:
		0:
			null_do ()
			sub_info1 = "null"
		1:
			plus_do ()
		2:
			Subtraction_do()
		3:
			times_do()
		4:
			division_do()


func null_do ():
	confirm.visible = false
	assign_func.visible = false

func plus_do ():
	confirm.visible = true
	assign_func.visible = true

func Subtraction_do():
	all_invisible()
	confirm.visible = true
	assign_func.visible = true
	plus.text = "-"
	plus.visible = true
	second_input.visible = true

func times_do():
	all_invisible()
	confirm.visible = true
	assign_func.visible = true
	plus.text = "x"
	plus.visible = true
	second_input.visible = true

func division_do():
	all_invisible()
	confirm.visible = true
	assign_func.visible = true
	plus.text = "/"
	plus.visible = true
	second_input.visible = true
	
func _on_confirm_pressed():
	info_is()

func all_invisible():
	option_button.visible = true
	confirm.visible = false
	assign_func.visible = false

func info_is():
	if option_button.get_selected_id() == 1:
		sub_info1 ="  " + sub_info1 + assign_func.text + " + " + second_input.text + "\n"
	if option_button.get_selected_id() == 2:
		sub_info1 ="  " + sub_info1 + assign_func.text + " - " + second_input.text + "\n"
	if option_button.get_selected_id() == 3:
		sub_info1 ="  " + sub_info1 + assign_func.text + " x " + second_input.text + "\n"
	if option_button.get_selected_id() == 4:
		sub_info1 ="  " + sub_info1 + assign_func.text + " / " + second_input.text + "\n"
