@tool
extends Control

var color = Color(1, 0, 0, 0.1)
var color1 = Color(0, 0, 0, 1)
var radius = 10
var pos = Vector2(0, 0)
func _draw() -> void:
	draw_circle(pos, radius+1, color)
	draw_circle(pos, radius, color)

