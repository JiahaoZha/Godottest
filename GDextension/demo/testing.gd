extends MeshInstance3D

var displacements = []
var current_index = 0
var interval = 1.0
var speed = 10.0
var initial_position = Vector3(0, 0, 0)
var duration = 2.0
# 加载文件并读取坐标
func _ready():
	var file = FileAccess.open("res://pathtesting.txt", FileAccess.READ)
	if file:
		while not file.eof_reached():
			var line = file.get_line()
			var displacement = parse_line_to_vector3(line)
			displacements.append(displacement)
		file.close()
	global_transform.origin = initial_position


	
# 将每行文本解析为 Vector3
func parse_line_to_vector3(line: String) -> Vector3:
	var parts = line.split(",")
	if parts.size() == 3:
		var x = parts[0].strip_edges().to_float()
		var y = parts[1].strip_edges().to_float()
		var z = parts[2].strip_edges().to_float()
		return Vector3(x, y, z)
	return Vector3()


func _on_timer_timeout():
	if current_index < displacements.size():
		current_index += 1



func _process(delta) -> void:
	var tween = create_tween()
	tween.tween_property(self, "global_position", global_position + displacements[current_index], duration )
	#var direction = displacements[current_index]-global_transform.origin
	#global_transform.origin = global_transform.origin + direction * delta
	
	

	


