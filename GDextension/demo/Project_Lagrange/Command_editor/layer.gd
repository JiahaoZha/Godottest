extends CanvasLayer

@onready var layer_1 = $"../layer_1"
@onready var save_button_2 = $Save_Button2

var all_info := ""
var nodes = []

func _on_save_button_2_pressed():
	sort_node()
	get_info()
	print(all_info)
	save_button_2.disabled = true
	
func sort_node():
	var child_node = layer_1.get_children()
	var first_node = null
	for child in child_node:
		if child.link_flag_up == false and child.link_flag_down == true:
			first_node = child
	var current_node = first_node
	while current_node != null:
		nodes.append(current_node)
		current_node = current_node.next_node



func get_info():
	for i in nodes:
		all_info += i.info
