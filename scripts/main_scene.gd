extends Node2D

func _ready() -> void:
	var player=GameManager.get_player()
	
	get_tree().current_scene.add_child(player)
	
	pass 
