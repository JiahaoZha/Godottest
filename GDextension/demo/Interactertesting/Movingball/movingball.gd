extends RigidBody3D

@onready var balltag: Label3D = $Balltag
@onready var highlight: MeshInstance3D = $Highlight
@onready var movingball: RigidBody3D = $"."
@onready var mainview: Camera3D = $"../Mainview"
@onready var controlpanel: Node2D = $Controlpanel

@export var speed := 10
@export var Jump_force := 10

func _input(event):
	if event.is_action_pressed("Jump"):
		linear_velocity.y = Jump_force

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("Forward"):
		transform.origin.z -= delta * speed
	if Input.is_action_pressed("Backward"):
		transform.origin.z += delta * speed
	if Input.is_action_pressed("Turn_left"):
		transform.origin.x -= delta * speed
	if Input.is_action_pressed("Turn_right"):
		transform.origin.x += delta * speed

func _process(delta) -> void:
	var Fview_x := movingball.transform.origin.x
	var Fview_z := movingball.transform.origin.z
	var Fview_y := movingball.transform.origin.y
	balltag.global_position = Vector3(Fview_x,2+Fview_y,Fview_z)
	mainview.global_position = Vector3(Fview_x,11+Fview_y,10+Fview_z)
	
func _on_area_3d_input_event(camera: Node, event: InputEvent, position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed == true:
			balltag.visible =! balltag.visible
			highlight.visible =! highlight.visible
			controlpanel.visible =! controlpanel.visible
			
			




