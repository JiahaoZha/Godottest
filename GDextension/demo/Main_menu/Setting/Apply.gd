extends Control

@onready var resolution_option_button: OptionButton = $Panel/HBoxContainer/VBoxContainer/OptionButton
@onready var setting_menu: Control = $"."



func _ready() -> void:
	add_resolution() 

func add_resolution():
	for r in GUI.resolution:
		resolution_option_button.add_item(r)


func update_button_values():
	var window_size_string = str(get_window().size.x, "x", get_window().size.y, "y")
	var resolution_index = GUI.resolution.keys().find(window_size_string)
	resolution_option_button.selected = resolution_index

func _on_option_button_item_selected(index: int) -> void:
	var key = resolution_option_button.get_item_text(index)
	get_window().set_size(GUI.resolution[key])
	
	
func _input(_event):
	if Input.is_action_just_pressed("toggle_settings"):
		setting_menu.visible = false
