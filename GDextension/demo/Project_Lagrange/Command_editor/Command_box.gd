extends VBoxContainer

var command_line_number :int = 10
var command_number :int = 0
var Command_array = []
@onready var layer_1 = $"../layer_1"

@onready var save_button = $"../Control/Save_Button"

@export var command_box: PackedScene

func _on_add_command_button_pressed():
	if command_number <= command_line_number:
		command_number += 1
		var add_box = command_box.instantiate()
		add_child(add_box)


func _on_delete_button_pressed():
	get_tree().reload_current_scene()


func _on_save_button_pressed():
	var child_node = layer_1.get_children()
	for node in child_node:
		var data =  node.info
		Command_array.append(data)

	save_data()

func save_data():
	var file = FileAccess.open("res://Project_Lagrange/Command_editor/command.txt",FileAccess.WRITE)
	for i in Command_array:
		file.store_line(str(i))
	file.close()
	save_button.disabled = true
