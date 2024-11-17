extends CanvasLayer

<<<<<<< Updated upstream
@onready var label: Label = $PanelContainer/Label
var DialogVisible:bool
var maxCharacters:int = 300

var visbleCharacters:float
=======
@onready var label: Label = $PanelContainer/MarginContainer/Label

var maxCharacters:int = 120
var currentLine: int = 0
var lines: Array = []
var visibleCharacters:float

var puzzleLayer: CanvasLayer
var finished:bool
>>>>>>> Stashed changes

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.execute_dialog.connect(_on_execute_dialog)
	SignalBus.wait_input.connect(_on_input_recived)
	pass # Replace with function body.


func _process(delta: float) -> void:
<<<<<<< Updated upstream
	
	if DialogVisible:
		visbleCharacters = label.visible_characters + 1
		label.visible_characters=visbleCharacters
		if label.visible_characters >= maxCharacters:
=======
	if GameManager.DialogVisible:
		if currentLine < lines.size():
			if visibleCharacters < lines[currentLine].length():
				visibleCharacters += 1
				label.text = lines[currentLine].substr(0, visibleCharacters)
			else:
				SignalBus.input_required.emit()
		else:
			finished=true
>>>>>>> Stashed changes
			SignalBus.input_required.emit()

		pass
		
		if label.visible_characters >= label.text.length():
			SignalBus.input_required.emit()

			pass
	
	pass


func _on_execute_dialog(text:String):
	print("Dialogo: "+text)
	label.text=text
	label.lines_skipped=0
	label.visible_characters=1
	show()
<<<<<<< Updated upstream
	DialogVisible=true
	pass

func _on_input_recived():
	label.lines_skipped+=1
	label.visible_characters=maxCharacters/2
	
	if label.visible_characters >= label.text.length():
		hide()
		DialogVisible = false
		
		pass
	
=======
	GameManager.DialogVisible = true
	finished=false
	pass

func _on_input_recived():
	if GameManager.DialogVisible and !finished:
		if currentLine < lines.size():
			currentLine += 1  # Avanza a la siguiente línea
			visibleCharacters = 0  # Reinicia los caracteres visibles para la nueva línea
			pass
	elif GameManager.DialogVisible and finished:
		print("Fin del diálogo.")
		hide()
		GameManager.DialogVisible = false
>>>>>>> Stashed changes

	
	pass
