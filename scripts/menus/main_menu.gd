extends CanvasLayer

func _on_play_button_pressed() -> void:
	TransitionScreen.transition()
	$Pressed.play()
	await SignalBus.on_transition_finished
	CanvasManager.play_opening()
	pass


func _on_options_button_pressed() -> void:
	CanvasManager.play_options_menu()
	$Pressed.play()
	pass # Replace with function body.


func _on_quit_button_pressed() -> void:
	get_tree().quit()
	$Pressed.play()
	pass # Replace with function body.


func _on_play_button_mouse_entered() -> void:
	$Hover.play()
	pass # Replace with function body.

func _on_options_button_mouse_entered() -> void:
	$Hover.play()
	pass # Replace with function body.

func _on_quit_button_mouse_entered() -> void:
	$Hover.play()
	pass # Replace with function body.
