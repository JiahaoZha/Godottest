extends Path3D

@export var enemy_scene: PackedScene
@export var difficulties: Node
@onready var timer: Timer = $Timer
@export var victory_layer: CanvasLayer
func spawn_enemy() -> void:
	var new_enemy = enemy_scene.instantiate()
	new_enemy.Max_health = difficulties.get_health()
	add_child(new_enemy)
	timer.wait_time = difficulties.get_spawn_time()
	new_enemy.tree_exited.connect(enemy_defeated)




func _on_difficultymanager_stop_spawning_enemies() -> void:
	timer.stop()
	
	
func enemy_defeated() ->void:
	if timer.is_stopped():
		for child in get_children():
			if child is PathFollow3D:
				return 
		print("you win!")
		victory_layer.victory()
