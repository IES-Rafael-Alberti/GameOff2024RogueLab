extends CanvasLayer

@onready var label: Label = $PanelContainer/Label
var DialogVisible:bool
var maxCharacters:int = 240

var visbleCharacters:float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.execute_dialog.connect(_on_execute_dialog)
	SignalBus.wait_input.connect(_on_input_recived)
	pass # Replace with function body.


func _process(delta: float) -> void:
	
	if DialogVisible:
		visbleCharacters = label.visible_characters + 1
		label.visible_characters=visbleCharacters
		if label.visible_characters >= maxCharacters:
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
	DialogVisible=true
	pass

func _on_input_recived():
	
	label.lines_skipped+=1
	label.visible_characters=label.lines_skipped*maxCharacters
	
	if label.visible_characters >= label.text.length():
		hide()
		DialogVisible = false
		
		pass
	

	
	pass
