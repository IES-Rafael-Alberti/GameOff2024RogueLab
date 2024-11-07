extends Control


func _on_resume_button_pressed() -> void:
	OptionManager.flagMenuPausa = false
	CanvasManager.play_resume_pause_menu()
	pass # Replace with function body.


func _on_options_button_pressed() -> void:
	CanvasManager.play_options_menu()
	pass # Replace with function body.


func _on_quit_button_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.
