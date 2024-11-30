extends CanvasLayer

@onready var mano_abierta: Sprite2D = $manoAbierta
@onready var mano_cerrada: Sprite2D = $manoCerrada

func _process(delta: float) -> void:
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		mano_cerrada.global_position = get_viewport().get_mouse_position() + Vector2(10, 10)
		mano_abierta.global_position = Vector2(-50, -50)
	else:
		mano_cerrada.global_position = Vector2(-50, -50)
		mano_abierta.global_position = get_viewport().get_mouse_position() + Vector2(10, 10)
	
	pass

func _ready() -> void:
	$Opening_Sounds.play()
	await get_tree().create_timer(35).timeout
	TransitionScreen.transition()
	await SignalBus.on_transition_finished
	CanvasManager.play_main_scene()
	pass # Replace with function body.

func _on_texture_button_pressed() -> void:
	TransitionScreen.transition()
	await SignalBus.on_transition_finished
	CanvasManager.play_main_scene()
	pass # Replace with function body.
