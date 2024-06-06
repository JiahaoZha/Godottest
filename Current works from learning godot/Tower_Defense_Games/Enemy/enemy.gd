extends PathFollow3D

@export var speed: float = 5
@export var Max_health: int = 50
@export var Reward_gold := 15

@onready var base = get_tree().get_first_node_in_group("base")
@onready var bank = get_tree().get_first_node_in_group("bank")
 
var current_health: int:
	set(health_in):
		if health_in < current_health:
			animation_player.play("Take_damage")
		current_health = health_in
		if current_health < 1:
			queue_free()
			bank.gold += Reward_gold
			

@onready var animation_player: AnimationPlayer = $AnimationPlayer
		
		 
func _ready() -> void:
	current_health = Max_health




func _process(delta: float) -> void:
	progress = progress + delta * speed
	if progress_ratio == 1.0:
		base.take_damage()
		set_process(false)
		queue_free() 
