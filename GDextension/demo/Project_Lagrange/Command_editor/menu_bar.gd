extends VBoxContainer

@onready var assign_bar = $assign_button/assign_bar
@onready var assign_button = $assign_button
@onready var functions_bar = $functions_button/functions_bar
@export var velocity_bar : PackedScene
@export var vector_bar :PackedScene
@export var loop_bar :PackedScene
@export var end_loop_bar :PackedScene
@export var if_bar:PackedScene
@export var end_if_bar:PackedScene
@onready var vector_button = $assign_button/assign_bar/Vector_button

@onready var layer_1 = $"../../layer_1"

func _ready():
	assign_bar.visible = false

func _process(delta):
	pass
	

func all_disable():
	assign_bar.visible = false
	functions_bar.visible = false
	
func _on_assign_button_pressed():
	all_disable()
	assign_bar.visible = true


func _on_functions_button_pressed():
	all_disable()
	functions_bar.visible = true


func _on_velocity_button_pressed():
	var new_bar = velocity_bar.instantiate()
	layer_1.add_child(new_bar)
	
	


func _on_vector_button_pressed():
	var new_bar = vector_bar.instantiate()
	layer_1.add_child(new_bar)


func _on_loop_button_pressed():
	var new_bar = loop_bar.instantiate()
	layer_1.add_child(new_bar)


func _on_end_loop_button_pressed():
	var new_bar = end_loop_bar.instantiate()
	layer_1.add_child(new_bar)


func _on_if_button_pressed():
	var new_bar = if_bar.instantiate()
	layer_1.add_child(new_bar)


func _on_end_if_button_pressed():
	var new_bar = end_if_bar.instantiate()
	layer_1.add_child(new_bar)
