extends Control

class_name HistorialPartidosSupabase

@onready var vbox = $VBoxContainer
@onready var back_btn = $VBoxContainer/BackButton

var partidas_panel: VBoxContainer
var http_request: HTTPRequest

func _ready() -> void:
	back_btn.pressed.connect(_on_back_pressed)
	
	# Crear HTTPRequest para obtener datos
	http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(_on_supabase_response)
	
	# Cargar partidas desde Supabase
	cargar_partidas_supabase()

func cargar_partidas_supabase() -> void:
	var headers = [
		"apikey: %s" % SupabaseManager.SUPABASE_KEY,
		"Authorization: Bearer %s" % SupabaseManager.SUPABASE_KEY
	]
	
	var url = "%s/rest/v1/partidas?order=id.desc&limit=50" % SupabaseManager.SUPABASE_URL
	
	print("📥 Cargando partidas desde Supabase...")
	http_request.request(url, headers, HTTPClient.METHOD_GET)

func _on_supabase_response(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	if result != HTTPRequest.RESULT_SUCCESS:
		print("❌ Error de conexión: ", result)
		_mostrar_error("Error de conexión a Supabase")
		return
	
	if response_code == 200:
		var json_string = body.get_string_from_utf8()
		var json = JSON.new()
		var partidas = json.parse_string(json_string)
		
		if partidas and partidas is Array:
			_mostrar_partidas(partidas)
		else:
			_mostrar_sin_partidas()
	else:
		print("❌ Error en la respuesta (Código: %d)" % response_code)
		_mostrar_error("Error: %d" % response_code)

func _mostrar_partidas(partidas: Array) -> void:
	# Limpiar panel anterior
	if partidas_panel:
		partidas_panel.queue_free()
	
	# Crear scroll view
	var scroll = ScrollContainer.new()
	scroll.custom_minimum_size = Vector2(600, 400)
	
	partidas_panel = VBoxContainer.new()
	scroll.add_child(partidas_panel)
	vbox.add_child(scroll)
	
	# Encabezado
	var header = Label.new()
	header.text = "📊 HISTORIAL DE PARTIDAS (Supabase)"
	header.add_theme_font_size_override("font_size", 20)
	partidas_panel.add_child(header)
	
	# Separador
	var separator = HSeparator.new()
	partidas_panel.add_child(separator)
	
	# Mostrar partidas
	for partida in partidas:
		var estado = "✅ COMPLETÓ" if partida.get("completado", false) else "❌ NO COMPLETÓ"
		var tiempo_str = _format_time(partida.get("tiempo", 0))
		var fecha = partida.get("fecha", "Sin fecha")
		
		var partida_label = Label.new()
		partida_label.text = "%s | %s | ⏱️ %s | 🪙 %d | 📅 %s" % [
			partida.get("nombre", "?"),
			estado,
			tiempo_str,
			partida.get("monedas", 0),
			fecha
		]
		partida_label.add_theme_font_size_override("font_size", 12)
		partidas_panel.add_child(partida_label)
		
		var separator2 = HSeparator.new()
		partidas_panel.add_child(separator2)

func _mostrar_sin_partidas() -> void:
	if partidas_panel:
		partidas_panel.queue_free()
	
	var label = Label.new()
	label.text = "No hay partidas registradas"
	label.add_theme_font_size_override("font_size", 18)
	vbox.add_child(label)

func _mostrar_error(mensaje: String) -> void:
	if partidas_panel:
		partidas_panel.queue_free()
	
	var label = Label.new()
	label.text = "❌ " + mensaje
	label.add_theme_font_size_override("font_size", 18)
	vbox.add_child(label)

func _format_time(t: float) -> String:
	var minutes: int = int(t) / 60
	var seconds: int = int(t) % 60
	var ms: int = int((t - int(t)) * 100)
	return "%02d:%02d.%02d" % [minutes, seconds, ms]

func _on_back_pressed():
	get_tree().change_scene_to_file("res://MainMenu.tscn")
