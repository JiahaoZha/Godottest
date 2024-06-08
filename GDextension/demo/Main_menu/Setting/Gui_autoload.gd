extends CanvasLayer


var gui_components = [
	"res://Main_menu/Setting/Settingscene.tscn"
]

var resolution = {
	"1980x1080": Vector2i(1980, 1080),
	"1366x768": Vector2i(1366, 768),
	"1280x720": Vector2i(1280, 720),
	"1440x900": Vector2i(1440, 900),
	"1600x900": Vector2i(1600, 900),
	"1024x600": Vector2i(1024, 600),
	"800x600": Vector2i(800, 600)
}

func _ready():
	for i in gui_components:
		var new_scren = load(i).instantiate()
		add_child(new_scren)
		new_scren.hide()
		




	
