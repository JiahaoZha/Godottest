extends Node3D

@onready var bgm = $bgm


# Called when the node enters the scene tree for the first time.
func _ready():
	bgm.play()



func _on_timer_timeout():
	bgm.play()
