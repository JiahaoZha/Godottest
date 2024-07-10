extends Node3D

@export var fire_rate := 14.0
@export var recoil := 0.05
@export var weapon_mesh: Node3D
@export var weapon_damage := 15
@export var muzzle_flash : GPUParticles3D
@export var sparks : PackedScene
@export var Scoping_position : Node3D
@export var Action : AnimationPlayer
@export var automatic: bool
@export var ammo_handler: Ammo_handler
@export var ammo_type : Ammo_handler.ammo_type
@export var empty_sound : AudioStreamPlayer3D
@export var reloading : AudioStreamPlayer3D


@onready var smooth_camera: Camera3D = $"../../../../../CameraPivot/Smooth_camera"
@onready var player: CharacterBody3D = $"../../../../.."
@onready var cooldown_timer: Timer = $CooldownTimer
@onready var weapon_position: Vector3 = weapon_mesh.position
@onready var ray_cast_3d: RayCast3D = $RayCast3D
@onready var gunfire: AudioStreamPlayer3D = $Gunfire



var can_shake := false

func _process(delta: float) -> void:
	gun_move()
	if Input.is_action_pressed("aim"):
		var tween = get_tree().create_tween()
		tween.tween_property(weapon_mesh, "position", Scoping_position.position, 0.1
		)
		can_shake = false
		
	if Input.is_action_just_released("aim"):
		can_shake = true
		
	if automatic == true:
		if Input.is_action_pressed("fire"):
			if cooldown_timer.is_stopped():
				shoot()
	else:
		if automatic == false:
			if Input.is_action_just_pressed("fire"):
				if cooldown_timer.is_stopped():
					shoot()
					
	weapon_mesh.position = weapon_mesh.position.lerp(weapon_position, delta * 10.0)
	
	if Input.is_action_just_pressed("Reload"):
		reload()
		

func shoot() -> void:
	if ammo_handler.has_ammo(ammo_type):
		ammo_handler.use_ammo(ammo_type)
		gunfire.play()
		muzzle_flash.restart()
		cooldown_timer.start(1.0/fire_rate)
		var collider = ray_cast_3d.get_collider()
		
		if collider is Enemy:
			collider.hitpoints -= weapon_damage
		weapon_mesh.position.z += recoil
		if ray_cast_3d.get_collider() != null:
			var spark = sparks.instantiate()
			add_child(spark)
			spark.global_position = ray_cast_3d.get_collision_point()
		screen_shake()
		gun_recoil()
	else:
		empty_sound.play()
		
		
func reload() -> void:
	if ammo_handler.Storage_has_ammo(ammo_type) and (ammo_handler.is_mage_full(ammo_type) == false):
		ammo_handler.reload_ammo(ammo_type)
		Action.play("Reload")
		reloading.play()
		set_process(false)



func _on_action_animation_finished(anim_name):
	set_process(true)
	
func screen_shake()-> void:#震动效果
	if can_shake:
		smooth_camera.rotation_degrees.x += 1

func gun_recoil()-> void:
	player.mouse_motion.y += 0.5 * recoil #后坐力

func gun_move()-> void:
	if Input.is_action_pressed("Move_forward") or Input.is_action_pressed("Move_backward"):
		Action.play("Moving")
		if Input.is_action_pressed("fire"):
			Action.stop(true)
	else:
		Action.stop(true)
