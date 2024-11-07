extends Control


func _on_play_button_pressed() -> void:
	CanvasManager.play_main_scene()
	pass


func _on_options_button_pressed() -> void:
	CanvasManager.play_options_menu()
	pass # Replace with function body.


func _on_quit_button_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.
