extends MeshInstance3D

@export_range(0.0, 200.0) var rotation_speed : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation_speed = 1.0
	var rotation_angle = rotation_speed * delta * 0.01
	rotate_y(rad_to_deg(rotation_angle))
