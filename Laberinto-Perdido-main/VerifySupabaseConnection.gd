extends Node

# Script de verificación rápida
# Agrega esto a una escena de prueba para verificar la conexión

var http_request: HTTPRequest

func _ready():
	http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(_on_response)
	
	print("🔍 Verificando conexión a Supabase...")
	verify_connection()

func verify_connection():
	var headers = [
		"apikey: sb_publishable_cBWmZNxLX3QRqJN0f1qS5A_w_ACNqWt",
		"Authorization: Bearer sb_publishable_cBWmZNxLX3QRqJN0f1qS5A_w_ACNqWt"
	]
	
	# Intentar leer un dato de prueba
	var url = "https://jqmehkoggwfxenlagsyr.supabase.co/rest/v1/partidas?select=count()&limit=1"
	http_request.request(url, headers, HTTPClient.METHOD_GET)

func _on_response(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	print("\n" + "=".repeat(50))
	print("📡 RESULTADO DE VERIFICACIÓN")
	print("=".repeat(50))
	
	if result != HTTPRequest.RESULT_SUCCESS:
		print("❌ Error de conexión: %d" % result)
		print("   Verifica tu conexión a internet")
		return
	
	print("✅ Conexión exitosa (HTTP %d)" % response_code)
	
	var body_text = body.get_string_from_utf8()
	print("📋 Respuesta: %s" % body_text)
	
	if response_code == 200:
		print("\n✅ ¡TODO ESTÁ FUNCIONANDO!")
		print("   La tabla 'partidas' está lista para recibir datos")
	else:
		print("\n❌ Hay un problema:")
		if response_code == 401:
			print("   - La API Key no es válida")
			print("   - Verifica que sea la 'anon public' key")
		elif response_code == 404:
			print("   - La tabla 'partidas' no existe")
			print("   - Ejecuta el SQL en SUPABASE_SETUP.md")
	
	print("=".repeat(50) + "\n")
	
	# Auto eliminar después de verificar
	call_deferred("queue_free")
