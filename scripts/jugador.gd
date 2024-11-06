extends CharacterBody2D
# variables
var interactionObject

# variables para diseñador
@export var SPEED = 130

# Variables para nodos
@onready var animated_sprite_2d = $AnimatedSprite2D  # Nodo para el sprite animado del personaje

#apartado de fisicas
func _physics_process(delta):
	
	#region movimiento
	
	# Obtiene la dirección de entrada y maneja el movimiento/desaceleración
	var directionLateral = Input.get_axis("ui_left2", "ui_right2")
	var directionVertical = Input.get_axis("ui_up2", "ui_down2")
	
	# Cambia la dirección del sprite según la dirección que toma el personaje
	if directionLateral > 0:
		animated_sprite_2d.flip_h = false  # No voltear el sprite
	elif directionLateral < 0:
		animated_sprite_2d.flip_h = true  # Voltear el sprite horizontalmente
		
	
	# Controla el movimiento horizontal del personaje
	if directionLateral:
		velocity.x = directionLateral * SPEED  # Movimiento basado en la dirección de entrada
	else:
		# Desacelera el personaje cuando no hay entrada
		velocity.x = move_toward(velocity.x, 0, SPEED)

# Controla el movimiento vertical del personaje
	if directionVertical:
		velocity.y = directionVertical * SPEED  # Movimiento basado en la dirección de entrada
	else:
		# Desacelera el personaje cuando no hay entrada
		velocity.y = move_toward(velocity.x, 0, SPEED)

#endregion

	#region interaccion
	
	if not interactionObject:
		pass
		
	elif Input.is_action_just_pressed("ui_interancion2"):
		print("interactuastes")
	
	
	#endregion
	# Mueve al personaje usando la física
	move_and_slide()
