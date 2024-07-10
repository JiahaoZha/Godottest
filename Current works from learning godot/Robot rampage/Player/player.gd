extends CharacterBody3D



@export var SPEED := 8.0
@export var Jump_height :float = 1.0
@export var fallspeed :float = 2.0
@export var max_hitpoints := 100
@export var aim_speed := 0.8
@export var aim_multiplier := 0.8
@onready var crosshair = $CenterContainer/Crosshair


var hitpoints: int = max_hitpoints:
	set(value):
		if value < hitpoints:
			damaged_animation_player.stop(false)
			damaged_animation_player.play("Damaged")
		hitpoints = value
		hp_label.text = str(hitpoints)
		
		if hitpoints <= 0:
			gameover.game_over()
			
@onready var ammo_handler: Ammo_handler = %Ammo_handler
@onready var camera_pivot: Node3D = $CameraPivot
@onready var damaged_animation_player: AnimationPlayer = $Damage/Damaged_AnimationPlayer
@onready var gameover: Control = $Gameover
@onready var hp_label = $MarginContainer/HP_label
@onready var smooth_camera: Camera3D = $CameraPivot/Smooth_camera
@onready var weapon_camera: Camera3D = %weapon_Camera


@onready var initial_view_fov := smooth_camera.fov
@onready var initial_weapon_fov := weapon_camera.fov
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var mouse_motion := Vector2.ZERO

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _physics_process(delta: float) -> void:
	handle_camera_rotation()
	# Add the gravity.
	if not is_on_floor():
		if velocity.y >= 0:
			velocity.y -= gravity * delta
		else:
			velocity.y -= gravity * delta * fallspeed

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = sqrt(Jump_height* 2.0 * gravity )

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("Move_left", "Move_right", "Move_forward", "Move_backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func _input(event: InputEvent) -> void:#鼠标移动
	if event is InputEventMouseMotion:
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			mouse_motion = -event.relative * 0.005
			if Input.is_action_pressed("aim"):#开镜速度
				mouse_motion *= aim_speed 
	if event.is_action_pressed("ui_cancel"):
		if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		else:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		
		
		
func handle_camera_rotation() ->void:
	rotate_y(mouse_motion.x)
	camera_pivot.rotate_x(mouse_motion.y)
	camera_pivot.rotation_degrees.x = clampf(
		camera_pivot.rotation_degrees.x, -90.0, 90.0 
	)
	mouse_motion = Vector2.ZERO


func _process(delta: float) -> void:

	if Input.is_action_pressed("aim"):#处理平滑镜头放大
		smooth_camera.fov = lerp(smooth_camera.fov, initial_view_fov * aim_multiplier, 0.05)
		weapon_camera.fov = lerp(weapon_camera.fov, initial_weapon_fov * aim_multiplier, 0.05)
		crosshair.visible = false
	else:
		crosshair.visible = true
		smooth_camera.fov = lerp(smooth_camera.fov, initial_view_fov, 0.05)
		weapon_camera.fov = lerp(weapon_camera.fov, initial_weapon_fov, 0.05)
