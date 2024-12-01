extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(5).timeout
	TransitionScreen.transition()
	await SignalBus.on_transition_finished
	CanvasManager.play_main_menu()
	
	pass
