extends Node


var childrens

func _ready() -> void:
	
	SignalBus.execute_puzzle.connect(_on_puzzle_execute)
	SignalBus.puzzle_exit.connect(_exit_puzzle)
	childrens = get_children()
	
	pass
	
	
func _on_puzzle_execute(event_id):
	print(event_id)
	if(GameManager.puzzleLayer==null):
		for child in childrens:
			if child.event_id == event_id:
				enterPuzzle(child)
			pass
	pass
	
func _exit_puzzle(puzzleLayer):
	puzzleLayer.hide()
pass
 
func enterPuzzle(child):
	child.show()
	print("Show Puzzle")
	SignalBus.puzzle_enter.emit(child)
