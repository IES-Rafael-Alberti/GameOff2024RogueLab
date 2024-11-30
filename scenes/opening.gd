extends CanvasLayer


func _ready() -> void:
	$Opening_Sounds.play()
	await get_tree().create_timer(31).timeout
	TransitionScreen.transition()
	await SignalBus.on_transition_finished
	CanvasManager.play_main_scene()
	pass # Replace with function body.

func _on_texture_button_pressed() -> void:
	TransitionScreen.transition()
	await SignalBus.on_transition_finished
	CanvasManager.play_main_scene()
	pass # Replace with function body.
