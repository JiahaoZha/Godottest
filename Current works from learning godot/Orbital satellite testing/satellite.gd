extends MeshInstance3D

@export_range(1.0, 9999.0) var orbit_radius :float
@export_range(1.0, 999.0) var orbit_speed :float

@onready var planet = $"../planet"
var current_angle = 0.0

var y = transform.origin.y
func _ready():
	transform.origin = transform.origin
	current_angle = 0.0
	
	print("Orbiting planet is ready")

func _process(delta):
	current_angle += orbit_speed*delta
	if current_angle >= 360.0:
		current_angle -= 360.0
	var x = planet.transform.origin.x+orbit_radius * cos(deg_to_rad((current_angle)))
	var z = planet.transform.origin.z+orbit_radius * sin(deg_to_rad((current_angle)))
	transform.origin = Vector3(x, y, z)


