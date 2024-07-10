extends Node

@onready var camera = $Camera


var scale :float = 1.0
var iniposition = Vector2.ZERO
var ini_camera_pos = Vector2.ZERO
var draging := false

func _ready():
	camera.zoom = Vector2(scale,scale)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			if scale <= 0.1:
				return
			scale -= 0.05
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
			if scale >= 10.0:
				return
			scale += 0.05
		if event.button_index == 2 or event.button_index == 3:
			if event.is_pressed():
				draging = true
				iniposition = event.position
				ini_camera_pos = camera.position
			else:
				draging = false
				iniposition = Vector2.ZERO
	if draging:
		var offset = iniposition - event.position
		camera.position = ini_camera_pos + offset
		
		
func _process(delta):
	camera.zoom = lerp(camera.zoom, Vector2(scale,scale), 8*delta)
