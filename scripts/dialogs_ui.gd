extends CanvasLayer

@onready var label: Label = $PanelContainer/MarginContainer/Label

var currentLine: int = 0
var lines: Array = []
var visibleCharacters:int

var puzzleLayer: CanvasLayer
var waiting_input:bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.execute_dialog.connect(_on_execute_dialog)
	SignalBus.wait_input.connect(_on_input_recived)
	pass # Replace with function body.


func _process(delta: float) -> void:
	if GameManager.DialogVisible and !waiting_input:
		if currentLine < lines.size():
			if visibleCharacters < lines[currentLine].length():
				visibleCharacters += 1
				label.text = lines[currentLine]
				label.visible_characters=visibleCharacters
			else:
				SignalBus.input_required.emit()
				waiting_input=true

	pass


func _on_execute_dialog(text:String):
	print("Dialogo: "+text)
	lines = text.split("\n")
	label.text=lines[0]
	label.lines_skipped=0
	label.visible_characters=1
	currentLine=0
	show()
	GameManager.DialogVisible=true
	pass

func _on_input_recived():
	if GameManager.DialogVisible and waiting_input:
		waiting_input=false
		if currentLine < lines.size():
			currentLine += 1  # Avanza a la siguiente línea
			visibleCharacters = 0  # Reinicia los caracteres visibles para la nueva línea
			
			if currentLine >=lines.size():
				print("Fin del diálogo.")
				hide()
				GameManager.DialogVisible = false
				GameManager.go_to_next()
				
			pass
		
	pass
