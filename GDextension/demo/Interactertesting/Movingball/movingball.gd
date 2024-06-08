extends RigidBody3D


@onready var balltag: Label3D = $Balltag
@onready var highlight: MeshInstance3D = $Highlight


@onready var mainview: Camera3D = $"../Mainview"





@export var speed := 10
@export var Jump_force := 10
@onready var movingball: RigidBody3D = $"."

var cam_h = 0 
var cam_v = 0

func _ready() -> void:
	var velocity := Vector3.ZERO



func _input(event):
	if event.is_action_pressed("Jump"):
		linear_velocity.y = Jump_force
	if event.is_action_pressed("Sprint"):
		linear_velocity = linear_velocity * 1.5
	
	if Input.is_action_pressed("ui_left"):
		mainview.rotation_degrees.y += 1
	if Input.is_action_pressed("ui_right"):
		mainview.rotation_degrees.y -= 1
	if Input.is_action_pressed("ui_up"):
		mainview.rotation_degrees.x += 1
	if Input.is_action_pressed("ui_down"):
		mainview.rotation_degrees.x -= 1
		
	

func _physics_process(delta: float) -> void:
	
	
	if Input.is_action_pressed("Forward"):
		linear_velocity.z -= delta * speed
		
	if Input.is_action_pressed("Backward"):
		linear_velocity.z += delta * speed
		
	if Input.is_action_pressed("Turn_left"):
		linear_velocity.x -= delta * speed
	
	if Input.is_action_pressed("Turn_right"):
		linear_velocity.x += delta * speed

func _process(delta) -> void:
	var Fview_x := movingball.transform.origin.x
	var Fview_z := movingball.transform.origin.z
	var Fview_y := movingball.transform.origin.y
	mainview.transform.origin = Vector3(Fview_x,8+Fview_y,5+Fview_z)
	balltag.global_position = Vector3(Fview_x,2+Fview_y,Fview_z)
	
	

func _on_area_3d_input_event(camera: Node, event: InputEvent, position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed == true:
			balltag.visible =! balltag.visible
			highlight.visible =! highlight.visible
			

