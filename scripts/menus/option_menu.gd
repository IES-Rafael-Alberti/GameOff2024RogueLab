extends CanvasLayer


func _on_back_button_pressed() -> void:
	CanvasManager.back_options_menu()
	pass # Replace with function body.



func _on_volume_master_slider_value_changed(value: float) -> void:
	OptionManager.volumenMaster = value
	pass # Replace with function body.


func _on_volume_music_slider_value_changed(value: float) -> void:
	OptionManager.volumenMusic=value
	pass # Replace with function body.


func _on_volume_sfx_slider_value_changed(value: float) -> void:
	OptionManager.volumenSFX = value
	pass # Replace with function body.


func _on_v_sync_check_button_toggled(toggled_on: bool) -> void:
	OptionManager.vsync=toggled_on
	pass # Replace with function body.
