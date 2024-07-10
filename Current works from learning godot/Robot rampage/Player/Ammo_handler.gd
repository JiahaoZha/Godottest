extends Node
class_name Ammo_handler
@export var ammolabel : Label
@export var weapon_handler: Node3D
@onready var pick_sound = $pick_sound

var Current_ammo: String

enum  ammo_type {
	BULLET,
	SMALL_BULLET
}
var Mag_storage :={
	ammo_type.BULLET: 10,
	ammo_type.SMALL_BULLET: 40
}

var Max_storage :={
	ammo_type.BULLET: 10,
	ammo_type.SMALL_BULLET: 40
}

var ammo_storage :={
	ammo_type.BULLET: 30,
	ammo_type.SMALL_BULLET: 120
}

func has_ammo(type: ammo_type) -> bool:
	return Mag_storage[type] > 0

func use_ammo(type: ammo_type) -> void:
	if has_ammo(type):
		Mag_storage[type]  -= 1
		updated_ammolabel(weapon_handler.get_weapon_ammo())

func add_ammo(type: ammo_type, amount: int) -> void:
	ammo_storage[type] += amount
	pick_sound.play()
	updated_ammolabel(weapon_handler.get_weapon_ammo()) 

func updated_ammolabel(type: ammo_type)-> void:
	Current_ammo = str(Mag_storage[type]) + "/" + str(ammo_storage[type])
	
	ammolabel.text = Current_ammo

func reload_ammo(type: ammo_type)-> void:
	if ammo_storage[type] > 0:
		var used_ammo = Max_storage[type]-Mag_storage[type]
		if used_ammo > ammo_storage[type]:
			Mag_storage[type] += ammo_storage[type]
			ammo_storage[type] = 0
		else:
			ammo_storage[type] = ammo_storage[type] - used_ammo
			Mag_storage[type] = Max_storage[type]
		updated_ammolabel(type)

func Storage_has_ammo(type: ammo_type) -> bool:
	return ammo_storage[type] > 0

func is_mage_full(type: ammo_type) -> bool:
	return Mag_storage[type] == Max_storage[type]


	
	
