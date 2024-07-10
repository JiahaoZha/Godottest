extends Area2D




func _on_area_entered(area):
	if area.name == "functions":
		var body = area.get_parent()
		body.queue_free()
