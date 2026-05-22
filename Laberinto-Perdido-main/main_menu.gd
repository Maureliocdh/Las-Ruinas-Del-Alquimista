extends Control

@onready var nueva_partida_btn: Button = $VBoxContainer/NuevaPartida
@onready var cargar_partida_btn: Button = $VBoxContainer/CargarPartida
@onready var dos_jugadores_btn: Button = $VBoxContainer/DosJugadores
@onready var opciones_btn: Button = $VBoxContainer/Opciones
@onready var salir_btn: Button = $VBoxContainer/Salir
@onready var name_input: LineEdit = $NameContainer/NameInput
@onready var name_input2: LineEdit = $NameContainer/NameInput2
@onready var label_j2: Label = $NameContainer/LabelJ2
@onready var label_error: Label = $NameContainer/LabelError

var modo_dos: bool = false

func _ready() -> void:
	name_input2.visible = false
	label_j2.visible = false
	_actualizar_boton()

	nueva_partida_btn.pressed.connect(_on_nueva_partida_pressed)
	cargar_partida_btn.pressed.connect(_on_cargar_partida_pressed)
	dos_jugadores_btn.pressed.connect(_on_dos_jugadores_pressed)
	opciones_btn.pressed.connect(_on_opciones_pressed)
	salir_btn.pressed.connect(_on_salir_pressed)
	name_input.text_changed.connect(func(_t): _actualizar_boton())
	name_input2.text_changed.connect(func(_t): _actualizar_boton())

func _on_dos_jugadores_pressed() -> void:
	modo_dos = not modo_dos
	name_input2.visible = modo_dos
	label_j2.visible = modo_dos
	if modo_dos:
		dos_jugadores_btn.text = " 2 Jugadores ✅"
		name_input2.grab_focus()
	else:
		dos_jugadores_btn.text = " 2 Jugadores"
		name_input2.text = ""
	_actualizar_boton()

func _actualizar_boton() -> void:
	var j1_ok: bool = name_input.text.strip_edges().length() > 0
	var j2_ok: bool = not modo_dos or name_input2.text.strip_edges().length() > 0
	var todo_ok: bool = j1_ok and j2_ok
	nueva_partida_btn.disabled = not todo_ok
	nueva_partida_btn.modulate = Color.WHITE if todo_ok else Color(0.55, 0.55, 0.55, 1.0)
	label_error.visible = false

func _go_to_loading(target: String) -> void:
	var loading = load("res://loading_screen.tscn").instantiate()
	loading.target_scene = target
	get_tree().root.add_child(loading)
	hide()

func _on_nueva_partida_pressed() -> void:
	var n1: String = name_input.text.strip_edges()
	var n2: String = name_input2.text.strip_edges()
	if n1.length() == 0 or (modo_dos and n2.length() == 0):
		label_error.visible = true
		if n1.length() == 0:
			name_input.grab_focus()
		else:
			name_input2.grab_focus()
		return
	if modo_dos:
		GameData.setup_two_players(n1, n2)
	else:
		GameData.setup_single(n1)
	_go_to_loading("res://game.tscn")

func _on_cargar_partida_pressed() -> void:
	var save_data = SaveManager.load_game()
	if save_data:
		# Configurar GameData con los datos guardados
		var player_name = save_data.get("extra_data", {}).get("player_name", "Jugador")
		GameData.setup_single(player_name)
		_go_to_loading(save_data["current_scene"])
	else:
		print("❌ No hay partida guardada")
		label_error.visible = true

func _on_opciones_pressed() -> void:
	print("Opciones (próximamente)")

func _on_salir_pressed() -> void:
	get_tree().quit()
