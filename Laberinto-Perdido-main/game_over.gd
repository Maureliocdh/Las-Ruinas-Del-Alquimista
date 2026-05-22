extends Control

@onready var retry_btn = $VBoxContainer/Reintentar
@onready var menu_btn = $VBoxContainer/"Menu principal"

func _ready():
	retry_btn.pressed.connect(_on_retry_pressed)
	menu_btn.pressed.connect(_on_menu_pressed)

func _on_retry_pressed():
	AudioManager.play_game_music()
	get_tree().change_scene_to_file("res://game.tscn")  # Ajusta la ruta de tu escena principal

func _on_menu_pressed():
	AudioManager.play_menu_music()
	get_tree().change_scene_to_file("res://MainMenu.tscn")  # Ajusta si tu menú tiene otro nombre
