extends Control

var target_scene: String = "res://game.tscn"

@onready var progress_bar: ProgressBar = $VBoxContainer/ProgressBar
@onready var label_tip: Label = $VBoxContainer/LabelTip
@onready var label_pct: Label = $VBoxContainer/LabelPct

const DURATION: float = 10.0
var elapsed: float = 0.0
var loading_done: bool = false
var tip_timer: float = 0.0
var current_tip_index: int = 0

const TIPS: Array = [
	"Explora cada rincón del laberinto...",
	"Recoge monedas para mejorar tu puntuación.",
	"Cuidado con los enemigos perseguidores.",
	"La bandera es tu meta. ¡No te rindas!",
	"Algunos caminos son trampas. Elige bien.",
	"Los power-ups pueden salvarte la vida.",
]

func _ready() -> void:
	progress_bar.min_value = 0.0
	progress_bar.max_value = 100.0
	progress_bar.value = 0.0
	current_tip_index = randi() % TIPS.size()
	label_tip.text = TIPS[current_tip_index]
	label_pct.text = "0%"

func _process(delta: float) -> void:
	if loading_done:
		hide()
		return

	elapsed += delta
	tip_timer += delta

	if tip_timer >= 3.0:
		tip_timer = 0.0
		current_tip_index = (current_tip_index + 1) % TIPS.size()
		label_tip.text = TIPS[current_tip_index]

	var pct: float = clamp(elapsed / DURATION, 0.0, 1.0)
	progress_bar.value = pct * 100.0
	label_pct.text = str(int(pct * 100)) + "%"

	if pct >= 1.0:
		loading_done = true
		await get_tree().create_timer(0.3).timeout
		get_tree().change_scene_to_file(target_scene)
