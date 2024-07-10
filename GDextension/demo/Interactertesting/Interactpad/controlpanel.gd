extends Node2D

@onready var controlpla: ColorRect = $Controlpla

var child_data_array = []
func _on_save_button_pressed() -> void:

	var child_node = controlpla.get_children()
	for child in child_node:
		if child is StaticBody2D:
			var data = child.C_number
			child_data_array.append(data)
	save_data()
		

func save_data():
	var file = FileAccess.open("res://Interactertesting/Interactpad/child_data.txt",FileAccess.WRITE)
	for i in child_data_array:
		file.store_line(str(i))
	file.close()
