extends RigidBody3D

## how much vertical force to apply when 
@export_range(750.0,3000.0) var Thrust: float = 1000.0

@export var torque_thrust: float = 100.0

var is_transitioning: bool = false
@onready var explosion: AudioStreamPlayer = $Explosion
@onready var Successbgm: AudioStreamPlayer = $Success
@onready var Rocketengin: AudioStreamPlayer3D = $rocketengin
@onready var fire_01: GPUParticles3D = $Fire01
@onready var fireleft: GPUParticles3D = $Fireleft
@onready var fireright: GPUParticles3D = $Fireright
@onready var boom: GPUParticles3D = $Boom
@onready var winflash: GPUParticles3D = $Winflash



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed( "boost"):
		apply_central_force(basis.y * delta * Thrust)
		fire_01.emitting = true
		if Rocketengin.playing == false:
			Rocketengin.play()
	else:
		fire_01.emitting = false
		Rocketengin.stop()
		
	if Input.is_action_pressed("rotate_left"):
		fireleft.emitting = true
		apply_torque(Vector3(0.0, 0.0, torque_thrust *delta))
	else:
		fireleft.emitting = false
	if Input.is_action_pressed("rotate_right"):
		fireright.emitting = true
		apply_torque(Vector3(0.0, 0.0, -torque_thrust *delta))
	else:
		fireright.emitting = false
		
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()



func _on_body_entered(body: Node) -> void:
	if is_transitioning == false:
		if "Goal"in body.get_groups():
			complete_level(body.file_path)
			
		if "Hazard"in body.get_groups():
			crash_squence()

func crash_squence() -> void:
	print("KABOOM!")
	boom.emitting = true
	explosion.play()
	set_process(false)
	is_transitioning = true
	var tween = create_tween()
	tween.tween_interval(2.0)
	tween.tween_callback(get_tree().reload_current_scene)

func complete_level(next_level_file: String) ->void:
	print("level complete")
	winflash.emitting = true
	Successbgm.play()
	set_process(false)
	is_transitioning = true
	var tween = create_tween()
	tween.tween_interval(1.5)
	tween.tween_callback(
		get_tree().change_scene_to_file.bind(next_level_file)
	)
