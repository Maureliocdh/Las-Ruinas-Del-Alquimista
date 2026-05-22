extends CanvasLayer

@onready var resume_btn = $VBoxContainer/Reanudar
@onready var menu_btn = $VBoxContainer/MenuPrincipal
@onready var opciones_btn = $VBoxContainer/Opciones
@onready var exit_btn = $VBoxContainer/Salir

func _ready():
	visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS  # ✅ Godot 4.5 usa "process_mode"

	resume_btn.pressed.connect(_on_resume_pressed)
	menu_btn.pressed.connect(_on_menu_pressed)
	opciones_btn.pressed.connect(_on_opciones_pressed)
	exit_btn.pressed.connect(_on_exit_pressed)

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if get_tree().paused:
			resume_game()
		else:
			pause_game()

func pause_game():
	get_tree().paused = true
	visible = true

func resume_game():
	get_tree().paused = false
	visible = false

func _on_resume_pressed():
	resume_game()

func _on_opciones_pressed():
	var options_menu = load("res://OptionsMenu.tscn").instantiate()
	add_child(options_menu)

func _on_menu_pressed():
	get_tree().paused = false
	AudioManager.play_menu_music()
	get_tree().change_scene_to_file("res://MainMenu.tscn")

func _on_exit_pressed():
	get_tree().quit()
