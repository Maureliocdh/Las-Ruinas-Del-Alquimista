extends Node

const SUPABASE_URL = "https://jqmehkoggwfxenlagsyr.supabase.co"
const SUPABASE_KEY = "sb_publishable_cBWmZNxLX3QRqJN0f1qS5A_w_ACNqWt"
const TABLE_NAME = "partidas"

var http_request: HTTPRequest
var _queue: Array = []
var _busy: bool = false

func _ready():
	http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(_on_request_completed)
	http_request.timeout = 30
	print("✅ SupabaseManager inicializado correctamente")
	print("   URL: %s" % SUPABASE_URL)
	print("   Tabla: %s" % TABLE_NAME)

func save_partida(nombre: String, monedas: int, tiempo: float, completado: bool) -> void:
	var data = {
		"nombre": nombre,
		"monedas": monedas,
		"tiempo": tiempo,
		"completado": completado,
		"fecha": Time.get_datetime_string_from_system()
	}
	_queue.append(data)
	print("📥 En cola: %s (pendientes: %d)" % [nombre, _queue.size()])
	_process_queue()

func _process_queue() -> void:
	if _busy or _queue.is_empty():
		return
	_busy = true
	var data = _queue.pop_front()
	_send_request(data)

func _send_request(data: Dictionary) -> void:
	var json_string = JSON.stringify(data)
	var headers = [
		"Content-Type: application/json",
		"apikey: %s" % SUPABASE_KEY,
		"Authorization: Bearer %s" % SUPABASE_KEY
	]
	var url = "%s/rest/v1/%s" % [SUPABASE_URL, TABLE_NAME]

	print("📤 Enviando partida a Supabase:")
	print("   Jugador: %s" % data["nombre"])
	print("   Monedas: %d" % data["monedas"])
	print("   Tiempo: %.2f s" % data["tiempo"])
	print("   Completado: %s" % ("SI" if data["completado"] else "NO"))

	var error = http_request.request(url, headers, HTTPClient.METHOD_POST, json_string)
	if error != OK:
		print("❌ Error al enviar solicitud HTTP: %d" % error)
		_busy = false
		_process_queue()

func _on_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	var body_text = body.get_string_from_utf8()

	print("📡 Respuesta de Supabase recibida:")
	print("   Código: %d" % response_code)
	print("   Result: %d" % result)

	if result != HTTPRequest.RESULT_SUCCESS:
		print("❌ Error de conexión: %d" % result)
		print("   Detalles: %s" % body_text)
	elif response_code == 201 or response_code == 200:
		print("✅ ¡Partida guardada exitosamente en Supabase!")
		if body_text:
			print("   Respuesta: %s" % body_text)
	else:
		print("❌ Error en la respuesta (Código: %d)" % response_code)
		print("   Mensaje: %s" % body_text)

	# Petición terminada, procesar la siguiente
	_busy = false
	_process_queue()

func get_all_partidas() -> void:
	var headers = [
		"apikey: %s" % SUPABASE_KEY,
		"Authorization: Bearer %s" % SUPABASE_KEY
	]
	var url = "%s/rest/v1/%s" % [SUPABASE_URL, TABLE_NAME]
	print("📥 Obteniendo partidas desde Supabase...")
	http_request.request(url, headers, HTTPClient.METHOD_GET)

static func format_time(t: float) -> String:
	var minutes: int = int(t) / 60
	var seconds: int = int(t) % 60
	var ms: int = int((t - int(t)) * 100)
	return "%02d:%02d.%02d" % [minutes, seconds, ms]
