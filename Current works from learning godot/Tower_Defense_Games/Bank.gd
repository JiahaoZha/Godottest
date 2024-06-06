extends MarginContainer

@export var staring_gold := 150 
@onready var label: Label = $Label

var gold: int:
	set(gold_in):
		gold = gold_in
		gold = max(gold_in, 0)
		label.text = "gold:" + str(gold)
		
func _ready() -> void:
	gold = staring_gold
	

