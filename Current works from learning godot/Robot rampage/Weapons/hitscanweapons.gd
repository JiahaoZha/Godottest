extends Node3D

@export var fire_rate := 14.0
@export var recoil := 0.05
@export var weapon_mesh: Node3D
@export var weapon_damage := 15
@export var muzzle_flash : GPUParticles3D
@export var sparks : PackedScene
@onready var smooth_camera: Camera3D = $".."

@onready var cooldown_timer: Timer = $CooldownTimer
@onready var weapon_position: Vector3 = weapon_mesh.position
@onready var ray_cast_3d: RayCast3D = $RayCast3D
@onready var gunfire: AudioStreamPlayer3D = $Gunfire


func _process(delta: float) -> void:
	if Input.is_action_pressed("fire"):
		if cooldown_timer.is_stopped():
			shoot()




		
	#recoil motion
	weapon_mesh.position = weapon_mesh.position.lerp(weapon_position, delta * 10.0)
	
	
func shoot() -> void:
	gunfire.play()
	muzzle_flash.restart()
	cooldown_timer.start(1.0/fire_rate)
	var collider = ray_cast_3d.get_collider()
	print("weapon fire",collider)
	if collider is Enemy:
		collider.hitpoints -= weapon_damage
	weapon_mesh.position.z += recoil
	var spark = sparks.instantiate()
	add_child(spark)
	spark.global_position = ray_cast_3d.get_collision_point()
	smooth_camera.rotation_degrees.x += 0.5 #震动效果
	
