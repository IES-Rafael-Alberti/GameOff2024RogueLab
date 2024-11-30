extends CanvasLayer

@onready var mano_abierta: Sprite2D = $manoAbierta
@onready var mano_cerrada: Sprite2D = $manoCerrada

func _process(delta: float) -> void:
	if !CanvasManager.inGame:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			mano_cerrada.global_position = get_viewport().get_mouse_position() + Vector2(10, 10)
			mano_abierta.global_position = Vector2(-50, -50)
		else:
			mano_cerrada.global_position = Vector2(-50, -50)
			mano_abierta.global_position = get_viewport().get_mouse_position() + Vector2(10, 10)
		
	pass

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
