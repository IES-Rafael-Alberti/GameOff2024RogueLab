extends Node2D

@onready var viewport = get_viewport()

func _ready():
	# Crear un nuevo ColorRect que cubra toda la pantalla
	var color_rect = ColorRect.new()
	add_child(color_rect)  # Añadir el ColorRect como hijo de la escena
	
	# Ajustar el tamaño del ColorRect para cubrir toda la pantalla
	
	#color_rect.rect_size = viewport.size  # Usamos el tamaño del Viewport (pantalla)

	# Cargar el shader de escala de grises
	var shader = load("res://grayscale_shader.shader")  # Cambia la ruta al archivo de tu shader
	
	# Crear un ShaderMaterial y asignarlo al ColorRect
	var shader_material = ShaderMaterial.new()
	shader_material.shader = shader
	color_rect.material = shader_material
