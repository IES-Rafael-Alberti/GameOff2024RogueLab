extends Node2D



# Variable para verificar si el objeto está siendo arrastrado
var arrastrando: bool = false
# Referencia al nodo Marker2D
var marker: Node2D

# Función que se llama al iniciar el arrastre
func _ready() -> void:
	marker = get_parent().get_node("Marker2D")  # Asegúrate de tener el Marker2D en el mismo Node2D padre
	pass



# Esta función detecta los eventos de entrada, como clics del ratón
func _unhandled_input(event: InputEvent) -> void:
	# Comprobar si el evento es un clic del ratón
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		print("clikIzquierdo")
		# Si el clic izquierdo está presionado y el mouse está cerca del objeto
		if event.pressed and get_global_mouse_position().distance_to(global_position) < 20.0:
			arrastrando = true  # Activar el arrastre
			print("arrastrando: true")
		else:
			arrastrando = false  # Desactivar el arrastre si se suelta el botón
			print("arrastrando: false")





# Esta función se llama cada fotograma para actualizar la posición si se está arrastrando
func _process(delta: float) -> void:
	if arrastrando:
		# Si está arrastrando, actualizar la posición para que siga al mouse
		global_position = get_global_mouse_position()
		print("cambiando posicion")
	
	# Verificar si el sprite ha alcanzado la posición del Marker2D
		if global_position.distance_to(marker.global_position) < 10.0:
			arrastrando = false  # Desactivar el arrastre cuando se llega a la posición del marker
			global_position = marker.global_position  # Asegurar que se quede en la posición del Marker2D
	
	
	