extends Node

# Nodos de audio - desde la escena .tscn
@onready var menu_player: AudioStreamPlayer = $MenuPlayer
@onready var game_player: AudioStreamPlayer = $GamePlayer
@onready var sfx_player: AudioStreamPlayer = $SFXPlayer

# Rutas de música
var MENU_MUSIC = "res://Audio/Sax jingles/jingles_SAX00.ogg"
var GAME_MUSIC = "res://Audio/8-Bit jingles/jingles_NES00.ogg"

# Volúmenes por defecto (en dB)
var menu_volume: float = -5.0  # Volumen audible
var game_volume: float = -5.0  # Volumen audible
var sfx_volume: float = -5.0

func _ready():
	# Cargar música
	var menu_stream = load(MENU_MUSIC)
	var game_stream = load(GAME_MUSIC)
	
	if menu_stream:
		menu_player.stream = menu_stream
		print("✅ Música de menú cargada correctamente")
	else:
		print("❌ Error cargando música de menú: ", MENU_MUSIC)
	
	if game_stream:
		game_player.stream = game_stream
		print("✅ Música de juego cargada correctamente")
	else:
		print("❌ Error cargando música de juego: ", GAME_MUSIC)
	
	# Configurar volumen inicial
	menu_player.volume_db = menu_volume
	game_player.volume_db = game_volume  # Ahora con volumen audible
	sfx_player.volume_db = sfx_volume
	
	# Reproducir música de menú automáticamente
	if menu_stream:
		menu_player.play()
		print("🎵 Reproduciendo música de menú automáticamente")
	
	print("🎵 AudioManager inicializado correctamente")

# Reproducir música del menú
func play_menu_music():
	game_player.stop()
	menu_player.volume_db = menu_volume
	if not menu_player.playing:
		menu_player.play()
	print("🎵 Reproduciendo música de menú")

# Reproducir música del juego
func play_game_music():
	menu_player.stop()
	game_player.volume_db = game_volume
	if not game_player.playing:
		game_player.play()
	print("🎵 Reproduciendo música de juego")

# Reproducir efecto de sonido
func play_sfx(audio_stream: AudioStream):
	sfx_player.stream = audio_stream
	sfx_player.volume_db = sfx_volume
	sfx_player.play()

# Detener toda la música
func stop_all_music():
	menu_player.stop()
	game_player.stop()
	print("🎵 Música detenida")

# Cambiar volumen de música de menú
func set_menu_volume(db: float):
	menu_volume = db
	if menu_player.playing:
		menu_player.volume_db = db

# Cambiar volumen de música de juego
func set_game_volume(db: float):
	game_volume = db
	if game_player.playing:
		game_player.volume_db = db

# Cambiar volumen de efectos
func set_sfx_volume(db: float):
	sfx_volume = db
	if sfx_player.playing:
		sfx_player.volume_db = db

# Cambiar volumen maestro
func set_master_volume(db: float):
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), db < -40)
	if db > -40:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), db)
