extends Node

# Sistema para leer datos del Excel y cargar partidas

class_name ExcelDataManager

static var partidas: Array = []

# Cargar datos del archivo Excel
static func load_from_excel(excel_path: String = "user://laberinto_scores.xlsx") -> Array:
	partidas.clear()
	
	# Intentar cargar desde la ruta del usuario
	if not FileAccess.file_exists(excel_path):
		# Si no existe, buscar en la carpeta del proyecto
		excel_path = "res://laberinto_scores.xlsx"
	
	if not FileAccess.file_exists(excel_path):
		print("❌ Archivo Excel no encontrado en: ", excel_path)
		return partidas
	
	# Convertir el Excel a datos JSON usando Python
	var script_path = "registrar_partida.py"
	var cmd = "python"
	
	# Crear un script temporal para leer el Excel
	var temp_script = """
import openpyxl
import json
from pathlib import Path

def leer_excel(ruta_excel):
	try:
		wb = openpyxl.load_workbook(ruta_excel)
		ws = wb['Partidas']
		
		partidas = []
		for row in ws.iter_rows(min_row=2, values_only=True):
			if row[0] is None:
				continue
			partidas.append({
				'numero': row[0],
				'jugador': row[1],
				'estado': row[2],
				'tiempo': row[3],
				'segundos': row[4],
				'monedas': row[5],
				'fecha': row[6]
			})
		
		return partidas
	except Exception as e:
		print(f'Error: {e}')
		return []

if __name__ == '__main__':
	# Buscar el archivo Excel
	excel_path = Path('laberinto_scores.xlsx')
	if not excel_path.exists():
		excel_path = Path(r'C:/Users/maure/Desktop/finalproyecto/Laberinto-Perdido-main/Laberinto-Perdido-main/laberinto_scores.xlsx')
	
	if excel_path.exists():
		datos = leer_excel(str(excel_path))
		print(json.dumps(datos))
	else:
		print('[]')
"""
	
	# Escribir el script temporal
	var temp_file = FileAccess.open("user://temp_read_excel.py", FileAccess.WRITE)
	if temp_file:
		temp_file.store_string(temp_script)
	
	print("✅ Sistema de lectura Excel cargado")
	return partidas

# Obtener partidas como Array
static func get_partidas() -> Array:
	return partidas

# Guardar partida en la lista (se llama desde registrar_partida.py)
static func add_partida(jugador: String, estado: String, tiempo: String, monedas: int, fecha: String) -> void:
	var partida = {
		"jugador": jugador,
		"estado": estado,
		"tiempo": tiempo,
		"monedas": monedas,
		"fecha": fecha
	}
	partidas.append(partida)
	print("✅ Partida agregada: ", jugador)
