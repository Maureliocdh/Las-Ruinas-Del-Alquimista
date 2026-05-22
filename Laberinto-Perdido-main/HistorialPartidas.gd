extends Control

@onready var vbox = $VBoxContainer
@onready var back_btn = $VBoxContainer/BackButton

# Panel de partidas
var partidas_panel: VBoxContainer

func _ready() -> void:
	back_btn.pressed.connect(_on_back_pressed)
	
	# Cargar partidas desde el JSON
	cargar_partidas()

func cargar_partidas() -> void:
	# Leer el archivo JSON de partidas
	var json_path = "C:/Users/maure/Desktop/finalproyecto/Laberinto-Perdido-main/Laberinto-Perdido-main/reporte_partida.json"
	var excel_path = "C:/Users/maure/Desktop/finalproyecto/Laberinto-Perdido-main/Laberinto-Perdido-main/laberinto_scores.xlsx"
	
	print("📊 Intentando cargar partidas desde: ", excel_path)
	
	# Intentar cargar datos con Python
	_cargar_desde_excel(excel_path)

func _cargar_desde_excel(excel_path: String) -> void:
	# Script Python para leer Excel y convertir a JSON
	var python_script = """
import openpyxl
import json

try:
	wb = openpyxl.load_workbook('%s')
	ws = wb['Partidas']
	
	partidas = []
	for row in ws.iter_rows(min_row=2, values_only=True):
		if row[0] is None:
			break
		partidas.append({
			'numero': row[0],
			'jugador': row[1] or 'Jugador',
			'estado': row[2] or '?',
			'tiempo': row[3] or '00:00.00',
			'monedas': row[5] or 0,
			'fecha': row[6] or '?'
		})
	
	print(json.dumps(partidas))
except Exception as e:
	print(json.dumps([]))
""" % excel_path
	
	# Guardar script temporal
	var temp_file = FileAccess.open("user://temp_load_scores.py", FileAccess.WRITE)
	if temp_file:
		temp_file.store_string(python_script)
		print("✅ Script temporal creado")
		_ejecutar_script_python()

func _ejecutar_script_python() -> void:
	var output: Array = []
	var result = OS.execute("python", ["user://temp_load_scores.py"], output)
	
	if result == 0 and output.size() > 0:
		var json_string = output[0]
		var json = JSON.new()
		var partidas = json.parse_string(json_string)
		
		if partidas and partidas is Array:
			_mostrar_partidas(partidas)
		else:
			_mostrar_sin_partidas()
	else:
		print("❌ Error ejecutando Python")
		_mostrar_sin_partidas()

func _mostrar_partidas(partidas: Array) -> void:
	# Limpiar panel anterior
	if partidas_panel:
		partidas_panel.queue_free()
	
	# Crear scroll view para las partidas
	var scroll = ScrollContainer.new()
	scroll.custom_minimum_size = Vector2(600, 400)
	
	partidas_panel = VBoxContainer.new()
	scroll.add_child(partidas_panel)
	
	# Agregar encabezado
	var header = Label.new()
	header.text = "📊 HISTORIAL DE PARTIDAS"
	header.add_theme_font_size_override("font_size", 24)
	partidas_panel.add_child(header)
	
	# Agregar separador
	var separator = HSeparator.new()
	partidas_panel.add_child(separator)
	
	# Agregar partidas
	for partida in partidas:
		var label = Label.new()
		var icono = "✅" if "Completó" in str(partida.get("estado", "")) else "❌"
		label.text = "%s %s - %s - ⏱️ %s - 💰 %d monedas - 📅 %s" % [
			icono,
			partida.get("jugador", "?"),
			partida.get("estado", "?"),
			partida.get("tiempo", "00:00.00"),
			partida.get("monedas", 0),
			partida.get("fecha", "?")
		]
		partidas_panel.add_child(label)
	
	# Insertar en el menú
	vbox.add_child(scroll)
	print("✅ %d partidas cargadas" % partidas.size())

func _mostrar_sin_partidas() -> void:
	if partidas_panel:
		partidas_panel.queue_free()
	
	var label = Label.new()
	label.text = "📭 No hay partidas guardadas aún"
	label.add_theme_font_size_override("font_size", 20)
	vbox.add_child(label)

func _on_back_pressed() -> void:
	queue_free()
