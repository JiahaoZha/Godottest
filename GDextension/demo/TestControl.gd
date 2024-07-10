extends Control
# printex.gd
@onready var printex_instance: printex = $printex

func _on_button_pressed() -> void:
	printex_instance.theword()
