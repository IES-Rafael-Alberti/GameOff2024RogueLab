extends Node

var ScriptDataPath = "res://data/ScriptSheet.json"

var scriptData= {}

func _ready() -> void:
	
	scriptData =  load_json_data_from_path(ScriptDataPath)
	
	pass # Replace with function body.

func load_json_data_from_path(path:String):
	
	if FileAccess.file_exists(path):
		print("Archivo de datos encontrado")
		
		var dataFile = FileAccess.open(path,FileAccess.READ)
		
		var parsedResult = JSON.parse_string(dataFile.get_as_text())
		if parsedResult is Dictionary:
			print("Archivo leido correctamente")
			return parsedResult
		else:
			print("Error: El archivo no se ha leido leer correctamente")
		
	else:
		print("Error: Archivo de datos no encontrado")
	
	pass
