extends Node


var childrens

func _ready() -> void:
	
	SignalBus.execute_puzzle.connect(_on_puzzle_execute)
	
	childrens = get_children()
	
	pass
	
	
func _on_puzzle_execute(event_id):
	for child in childrens:
		if child.event_id == event_id:
			child.show()
			pass
		pass
	pass
	
func _exit_puzzle(puzzleLayer):
	puzzleLayer.hide()
pass
