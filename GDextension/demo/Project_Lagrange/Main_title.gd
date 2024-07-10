extends Node2D


@onready var setting_menu: Control = $"Setting menu"



func _on_button_option_pressed() -> void:
	setting_menu.visible = true
	

