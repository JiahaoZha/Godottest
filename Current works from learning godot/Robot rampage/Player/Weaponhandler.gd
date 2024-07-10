extends Node3D

@export var weapon1: Node3D
@export var weapon2: Node3D
@export var switch_gun : AudioStreamPlayer



func _ready() -> void:
	equip(weapon2)
	
func _unhandled_input(event: InputEvent) -> void:	
	if event.is_action_pressed("weapon_1"):
		equip(weapon1)
	if event.is_action_pressed("weapon_2"):
		equip(weapon2)
	if event.is_action_pressed("next_weapon_action"):
		next_weapon()
	if event.is_action_pressed("last_weapon"):
		last_weapon()
	
func equip(active_weapon: Node3D) ->void:
	switch_gun.play()
	var start_position := active_weapon.position
	for child in get_children():
		if child == active_weapon:
			child.visible = true
			child.set_process(true)
			child.ammo_handler.updated_ammolabel(child.ammo_type)
			active_weapon.position = start_position - Vector3(0.2,0.4,0.5)
			var tween = get_tree().create_tween()
			tween.set_trans(Tween.TRANS_SINE)
			tween.tween_property(active_weapon, "position", start_position + Vector3(0,0.03,-0.1), 0.3)
			tween.tween_property(active_weapon, "position", start_position, 0.1)
			
		else:
			child.visible = false
			child.set_process(false)
			
func next_weapon() -> void:
	var index = get_current_index()
	index = wrapi(index + 1, 0, get_child_count())
	equip(get_child(index))
	

func last_weapon() -> void:
	var index = get_current_index()
	index = wrapi(index - 1, 0, get_child_count())
	equip(get_child(index))
	
func get_current_index()-> int:
	for index in get_child_count():
		if get_child(index).visible:
			return index
	return 0

func get_weapon_ammo() -> Ammo_handler.ammo_type:
	return get_child(get_current_index()).ammo_type
