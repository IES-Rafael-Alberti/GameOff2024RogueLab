extends CanvasLayer

@onready var label: Label = $PanelContainer/MarginContainer/Label
const MAIN_MENU = preload("res://scenes/UI/main_menu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Ejecutando script ending")
	if OptionManager.language == "ES":
		label.text = "La puerta se abrió, como era de esperar, así que decidí salir del apartamento.
		Vi la policía subir las escaleras, y uno a lo lejos me preguntó sobre que había visto de extraño
		recientemente en el recinto. Pasé de largo y decidí bajar el edificio, no me sentía nada bien
		y quería salir rápidamente de ese lugar, encontrar otro tipo de ayuda... Tras unos cinco minutos, varios
		cuerpos me reducieron y fui arrestado por ser el principal sospechoso de ese asesinato.
		
		Final 1/3"
	else:
		label.text = "Ending 1"	
	pass # Replace with function body.
	
func _on_menu_button_pressed() -> void:
	CanvasManager.play_main_menu()
	pass # Replace with function body.
