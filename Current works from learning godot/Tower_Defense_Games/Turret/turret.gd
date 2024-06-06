extends Node3D

@export var projectile: PackedScene
@export var turret_range :=10.0
var enemy_path: Path3D
var target: PathFollow3D


@onready var turrettop: Node3D = $Turretbase/Turrettop
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var cannon: Node3D = $Turretbase/Turrettop/Cannon
@onready var turretbase: Node3D = $Turretbase

func _physics_process(delta: float) -> void:
	target = find_best_target()
	if target != null:
		turretbase.look_at(target.global_position, Vector3.UP, true)

func _on_timer_timeout() -> void:
	if target:
		var shot = projectile.instantiate()
		add_child(shot)
		shot.global_position = cannon.global_position
		shot.direction = turretbase.global_transform.basis.z
		animation_player.play("Fire")

func find_best_target() -> PathFollow3D:
	var best_target = null
	var best_progess = 0
	for enemy in enemy_path.get_children():
		if enemy is PathFollow3D:
			if enemy.progress > best_progess:
				var distance := global_position.distance_to(enemy.global_position)
				if distance < turret_range:
					best_target = enemy
					best_progess = enemy.progress
	return best_target
