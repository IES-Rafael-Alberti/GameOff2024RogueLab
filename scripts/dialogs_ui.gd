extends CanvasLayer

@onready var label: Label = $PanelContainer/MarginContainer/Label
const ENDING = preload("res://scenes/Prefabs/Ending.tscn")

var currentLine: int = 0
var lines: Array = []
var visibleCharacters:int

var puzzleLayer: CanvasLayer
var waiting_input:bool
var event_id:String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.execute_dialog.connect(_on_execute_dialog)
	SignalBus.wait_input.connect(_on_input_recived)
	SignalBus.languageChange.connect(languageChange)
	pass # Replace with function body.

func languageChange():
	
	if GameManager.DialogVisible:
		waiting_input = false
		lines = GameManager.get_event(event_id)[OptionManager.language].split("\n")
		label.text=lines[0]
		label.lines_skipped=0
		label.visible_characters=1
		currentLine=0
		show()
		GameManager.DialogVisible=true
		
	pass
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


func _on_execute_dialog(text:String, event_id:String):
	#print("Dialogo: "+text)
	self.event_id = event_id
	#GameManager.get_event(event_id)[OptionManager.language]
	lines = GameManager.get_event(event_id)[OptionManager.language].split("\n")
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
				
				if GameManager.zoomItem:
					SignalBus.exit_zoom_item.emit()
				
				print("Fin del diálogo.")
				hide()
				GameManager.DialogVisible = false
				GameManager.go_to_next()
				check_endings()
			pass
		
	pass
	
func check_endings():
	var next_event_id = GameManager.get_event(event_id)["NEXT"]
	if next_event_id == "Ev_Ending_01":
		GameManager.setInteractive(null)
		GameManager.evento=null
		TransitionScreen.transition()
		await SignalBus.on_transition_finished
		SignalBus.ending_info.emit(GameManager.get_event(next_event_id)[OptionManager.language])
	pass	
