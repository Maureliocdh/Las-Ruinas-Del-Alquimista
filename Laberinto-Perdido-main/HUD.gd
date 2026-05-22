extends CanvasLayer

@onready var coin_label: Label = $CoinLabel
@onready var timer_label: Label = $TimerLabel
@onready var health_bar = $HealthBar
@onready var damage_sound = $DamageSound

var coins: int = 0
var time_elapsed: float = 0.0
var max_health: int = 100
var current_health: int = 100
var _turno_terminado: bool = false

func _ready() -> void:
	add_to_group("hud")
	update_health_bar()
	coin_label.text = "Monedas: 0"
	_mostrar_turno()

func _mostrar_turno() -> void:
	if GameData.is_two_player_mode:
		var num = GameData.current_player_index + 1
		timer_label.text = "🎮 J%d — %s | Tiempo: 0.0 s" % [num, GameData.current_name()]
	else:
		timer_label.text = "Tiempo: 0.0 s"

# --- 🪙 MONEDAS ---
func _on_coin_collected() -> void:
	coins += 1
	GameData.set_coins(coins)
	coin_label.text = "Monedas: %d" % coins

# --- ⏱️ TIEMPO ---
func update_timer(delta: float) -> void:
	time_elapsed += delta
	GameData.set_time(time_elapsed)
	if GameData.is_two_player_mode:
		var num = GameData.current_player_index + 1
		timer_label.text = "🎮 J%d %s | ⏱ %s s" % [num, GameData.current_name(), str(snapped(time_elapsed, 0.1))]
	else:
		timer_label.text = "Tiempo: %s s" % str(snapped(time_elapsed, 0.1))

# --- ❤️ VIDA ---
func update_health_bar() -> void:
	health_bar.value = current_health

func take_damage(amount: int) -> void:
	current_health = max(current_health - amount, 0)
	update_health_bar()
	if damage_sound and not damage_sound.playing:
		damage_sound.play()
	if current_health <= 0:
		player_died()

func heal(amount: int) -> void:
	current_health = min(current_health + amount, max_health)
	update_health_bar()

# --- ☠️ MUERTE ---
func player_died() -> void:
	if _turno_terminado:
		return
	_turno_terminado = true
	GameData.set_completed(false)
	GameData.print_report()
	if GameData.has_next_player():
		# J1 murió, J2 todavía no juega → pasar turno
		GameData.next_player()
		get_tree().reload_current_scene()
	else:
		# Era el último jugador (J2 en 2J, o J1 en 1J) → guardar y menú
		_save_to_supabase()
		get_tree().change_scene_to_file("res://MainMenu.tscn")

# --- 🏁 META ---
# Solo guarda datos. El fade y navegación los maneja flag_reached_screen.gd
func turno_completado() -> void:
	if _turno_terminado:
		return
	_turno_terminado = true
	GameData.set_completed(true)
	GameData.print_report()

# --- 💾 SUPABASE ---
func _save_to_supabase() -> void:
	print("🔄 Iniciando guardado en Supabase...")
	if SupabaseManager:
		for player in GameData.players:
			print("  → Guardando: %s" % player["name"])
			SupabaseManager.save_partida(
				player["name"],
				player["coins"],
				player["time"],
				player["completed"]
			)
		print("✅ Datos enviados a Supabase")
	else:
		print("❌ SupabaseManager no está disponible")
