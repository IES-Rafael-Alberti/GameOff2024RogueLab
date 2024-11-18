extends TextureButton



var pesionando: bool = false


# Función que se llama al iniciar el arrastre
func _ready() -> void:
	pass


# Esta función se llama cada fotograma para actualizar la posición si se está arrastrando
func _process(delta: float) -> void:
	if pesionando:
		print("cambiando posicion")
		global_position = get_global_mouse_position()
		


func _on_button_up() -> void:
	pesionando = false
	print("_on_button_up()")


func _on_button_down() -> void:
	pesionando = true
	print("_on_button_down()")
