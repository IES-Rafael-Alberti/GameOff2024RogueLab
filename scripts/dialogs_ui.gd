extends CanvasLayer

@onready var label: Label = $PanelContainer/MarginContainer/Label
@onready var puzzle_rejilla: CanvasLayer = $PuzzleRejilla

var DialogVisible:bool
var maxCharacters:int = 120
var currentLine: int = 0
var lines: Array = []
var visibleCharacters:float

var puzzleLayer: CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.execute_dialog.connect(_on_execute_dialog)
	SignalBus.wait_input.connect(_on_input_recived)
	SignalBus.puzzle_enter.connect(_setPuzzleLayer)
	pass # Replace with function body.

func _setPuzzleLayer(puzzleLayer: CanvasLayer):
	self.puzzleLayer = puzzleLayer
	pass

func _process(delta: float) -> void:
	if DialogVisible:
		if currentLine < lines.size():
			if visibleCharacters < lines[currentLine].length():
				visibleCharacters += 1
				label.text = lines[currentLine].substr(0, visibleCharacters)
			else:
				SignalBus.input_required.emit()
		else:
			SignalBus.input_required.emit()

	pass

func _on_execute_dialog(text: String):
	print("Diálogo: " + text)
	lines = text.split("\n")  # Divide el texto en líneas
	currentLine = 0
	visibleCharacters = 0
	label.text = ""
	show()
	DialogVisible = true
	pass

func _on_input_recived():
	if currentLine < lines.size():
		currentLine += 1  # Avanza a la siguiente línea
		visibleCharacters = 0  # Reinicia los caracteres visibles para la nueva línea
		if currentLine >= lines.size():
			print("Fin del diálogo.")
			hide()
			DialogVisible = false
			if (self.puzzleLayer != null):
				SignalBus.puzzle_exit.emit(puzzleLayer)
				self.puzzleLayer = null
			pass	
		pass

	pass
