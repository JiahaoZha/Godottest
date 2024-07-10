@tool
extends Control


var outner :=10
var iner :=5
func _draw() -> void:
	#draw_circle(Vector2.ZERO, 2, Color.GREEN)

	draw_line(Vector2(iner-1, 0), Vector2(outner-1, 0), Color.GREEN, 1)
	draw_line(Vector2(-iner, 0), Vector2(-outner, 0), Color.GREEN, 1)
	draw_line(Vector2(0, iner), Vector2(0, outner), Color.GREEN, 1)
	draw_line(Vector2(0, -iner), Vector2(0, -outner), Color.GREEN, 1)
