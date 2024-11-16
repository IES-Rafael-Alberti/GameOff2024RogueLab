extends Node

func _ready() -> void:
	
	SignalBus.execute_puzzle.connect(_on_puzzle_execute)
	
	pass
	
	
func _on_puzzle_execute():
	
	pass
