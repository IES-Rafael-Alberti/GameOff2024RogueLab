extends Sprite2D

# Variable para almacenar si el clic izquierdo se ha realizado
var clicked_left: bool = false

# Detectar entrada del ratón (clic izquierdo)
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and get_global_mouse_position().distance_to(global_position) < 20.0:
		print("clikIzquierdo")  # Si se hace clic izquierdo
		if event.pressed and get_global_mouse_position().distance_to(global_position) < 40.0:
			clicked_left = true  # Cambia el estado a true al hacer clic
			print("Clic izquierdo detectado")






# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if clicked_left: #if clicked_left and GameManager.destornillador:  # Verifica que GameManager.flag1 esté activado
		clicked_left = false
		GameManager.flag1 = true
		print("pastillas quitadas flag1: " + str(GameManager.flag1))
		queue_free()
	
	pass
