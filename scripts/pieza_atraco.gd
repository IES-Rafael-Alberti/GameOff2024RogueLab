extends TextureButton

@onready var puzzle_mapa_atraco: CanvasLayer = $"../.."


var pesionando: bool = false
# Almacena el desplazamiento entre la posición del ratón y el botón
var offset: Vector2 = Vector2.ZERO

# Función que se llama al iniciar el arrastre
func _ready() -> void:
	pass


# Esta función se llama cada fotograma para actualizar la posición si se está arrastrando
func _process(delta: float) -> void:
	if pesionando:
		#print("cambiando posicion")
		global_position = get_global_mouse_position() + offset
		


func _on_button_up() -> void:
	pesionando = false
	var marcador = puzzle_mapa_atraco.comprobarMarcador(self)#obtenemos el marcador correspondiente
	puzzle_mapa_atraco.comprobarPosicion(self, marcador)#comprovamos si esta en su sitio
	#print("_on_button_up()")


func _on_button_down() -> void:
	if !GameManager.mapa:
		pesionando = true
		offset = global_position - get_global_mouse_position()
		#print("_on_button_down()")
