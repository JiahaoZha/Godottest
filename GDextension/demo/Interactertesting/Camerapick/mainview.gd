extends Camera3D

@onready var viewpicker: RayCast3D = $Viewpicker



func _process(delta: float) -> void:
	var mouse_position: Vector2 = get_viewport().get_mouse_position()
	viewpicker.target_position = project_local_ray_normal(mouse_position) * 100.0
	viewpicker.force_raycast_update()
	if viewpicker.is_colliding():
		var colloider = viewpicker.get_collider()
		pass
