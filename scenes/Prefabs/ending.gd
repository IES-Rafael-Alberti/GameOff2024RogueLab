extends CanvasLayer


@onready var label: Label = $PanelContainer/MarginContainer/Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Ejecutando script ending")
	if GameManager.language == "ES":
		label.text = "Final 1"
	else:
		label.text = "Ending 1"	
	pass # Replace with function body.
