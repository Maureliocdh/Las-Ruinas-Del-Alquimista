extends Control

@onready var menu_volume_slider: HSlider = $VBoxContainer/MenuVolume/MenuVolumeSlider
@onready var game_volume_slider: HSlider = $VBoxContainer/GameVolume/GameVolumeSlider
@onready var sfx_volume_slider: HSlider = $VBoxContainer/SFXVolume/SFXVolumeSlider
@onready var master_volume_slider: HSlider = $VBoxContainer/MasterVolume/MasterVolumeSlider
@onready var back_btn: Button = $VBoxContainer/BackButton

# Labels para mostrar valores
@onready var menu_value_label: Label = $VBoxContainer/MenuVolume/MenuValueLabel
@onready var game_value_label: Label = $VBoxContainer/GameVolume/GameValueLabel
@onready var sfx_value_label: Label = $VBoxContainer/SFXVolume/SFXValueLabel
@onready var master_value_label: Label = $VBoxContainer/MasterVolume/MasterValueLabel

func _ready() -> void:
	# Configurar sliders
	_setup_slider(menu_volume_slider, "Música Menú", menu_value_label, AudioManager.menu_volume)
	_setup_slider(game_volume_slider, "Música Juego", game_value_label, AudioManager.game_volume)
	_setup_slider(sfx_volume_slider, "Efectos de Sonido", sfx_value_label, AudioManager.sfx_volume)
	_setup_slider(master_volume_slider, "Volumen Maestro", master_value_label, 0.0)
	
	# Conectar señales
	menu_volume_slider.value_changed.connect(_on_menu_volume_changed)
	game_volume_slider.value_changed.connect(_on_game_volume_changed)
	sfx_volume_slider.value_changed.connect(_on_sfx_volume_changed)
	master_volume_slider.value_changed.connect(_on_master_volume_changed)
	back_btn.pressed.connect(_on_back_pressed)
	
	print("⚙️ Panel de opciones abierto")

func _setup_slider(slider: HSlider, label: String, value_label: Label, initial_value: float):
	slider.min_value = -40
	slider.max_value = 0
	slider.step = 1
	slider.value = initial_value
	_update_label(value_label, initial_value)

func _update_label(label: Label, value: float):
	if value <= -40:
		label.text = "Silenciado"
	else:
		label.text = "%.0f dB" % value

func _on_menu_volume_changed(value: float) -> void:
	AudioManager.set_menu_volume(value)
	_update_label(menu_value_label, value)

func _on_game_volume_changed(value: float) -> void:
	AudioManager.set_game_volume(value)
	_update_label(game_value_label, value)

func _on_sfx_volume_changed(value: float) -> void:
	AudioManager.set_sfx_volume(value)
	_update_label(sfx_value_label, value)

func _on_master_volume_changed(value: float) -> void:
	AudioManager.set_master_volume(value)
	_update_label(master_value_label, value)

func _on_back_pressed() -> void:
	queue_free()
	print("⚙️ Panel de opciones cerrado")
