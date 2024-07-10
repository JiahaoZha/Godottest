extends Node2D

var draggable = false
var is_dropable_place = false
var body_ref
var offset: Vector2
var initialPos: Vector2

@export var mark: PackedScene
func _process(delta):
	
	
	if draggable:
		if Input.is_action_pressed("Mouse_click"):
			initialPos = global_position
			global_position = get_global_mouse_position()
		elif Input.is_action_just_released("Mouse_click"):
			global.is_dragging = false
			var tween = get_tree().create_tween()
			if is_dropable_place:
				tween.tween_property(self,"position",body_ref.position,0.1).set_ease(Tween.EASE_OUT)
				body_ref.is_sth_inside = true
				body_ref.showtime = true
				body_ref.C_number = 1
			else:
				tween.tween_property(self,"global_position",initialPos,0.1).set_ease(Tween.EASE_OUT)



func _on_area_2d_mouse_entered():
	if not global.is_dragging:
		draggable = true
		scale = Vector2(1.05, 1.05)

func _on_area_2d_mouse_exited():
	if not global.is_dragging:
		draggable = false
		scale = Vector2(1,1)
		
func _on_area_2d_body_entered(body: StaticBody2D):
	if body.is_in_group("dropable"):
		is_dropable_place = true
		body_ref = body

func _on_area_2d_body_exited(body):
	if body.is_in_group("dropable"):
		is_dropable_place = true






