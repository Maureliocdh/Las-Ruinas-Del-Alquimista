extends Label3D

func _ready():
	text = GameData.current_name()
	billboard = BaseMaterial3D.BILLBOARD_ENABLED
	no_depth_test = true
	modulate = Color(1, 0.95, 0.4, 1)   # amarillo dorado
	outline_modulate = Color(0, 0, 0, 1)
	outline_render_priority = -1
	font_size = 52
	position = Vector3(0, 2.4, 0)       # flota encima de la cabeza
