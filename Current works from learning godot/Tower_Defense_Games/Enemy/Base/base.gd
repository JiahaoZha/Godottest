extends Node3D
@export var Max_health: int = 5
var red: Color = Color.RED
var white: Color = Color.WHITE
var current_health: int:
	set(health_in):
		current_health = health_in
		
		label_3d.text = str(current_health) + "/" + str(Max_health)
		label_3d.modulate = red.lerp(white, float(current_health) / float(Max_health))
		if current_health < 1: 
			get_tree().reload_current_scene()
		
@onready var label_3d: Label3D = $Label3D


func _ready() -> void:
	
	current_health = Max_health
	label_3d.text = str(current_health) + "/" + str(Max_health)
	


func take_damage() -> void:
		
	current_health = current_health -1



