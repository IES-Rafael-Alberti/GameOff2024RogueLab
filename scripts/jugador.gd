extends CharacterBody2D
# variables
var interactionObject #objeto que se recive
var flagInteractuando = false #indicador si se esta interactuando o no


# variables para diseñador
@export var SPEED = 130

# Variables para nodos
@onready var animated_sprite_2d = $AnimatedSprite2D  # Nodo para el sprite animado del personaje

#apartado de fisicas
func _physics_process(delta):

	#region menu de pausa
	
	if Input.is_action_just_pressed("escape"):
		if OptionManager.flagMenuPausa:
			OptionManager.flagMenuPausa = false
			CanvasManager.play_resume_pause_menu()
			print("MenuPausa: " + str(OptionManager.flagMenuPausa) )
		else:
			OptionManager.flagMenuPausa = true
			GameManager.positionPlayer=position
			CanvasManager.play_pause_menu()
			print("MenuPausa: " + str(OptionManager.flagMenuPausa))

	#endregion

	#region interaccion
	
	
	if !not interactionObject: #cambia de !not a not (esta en !not para provar que funciona)
		flagInteractuando = false
		print("no hay objeto ")
		
	elif Input.is_action_just_pressed("interancion"):
		flagInteractuando = true
		print("Estoy Interactuando: " + str(flagInteractuando))
	
	
	#endregion

	#region movimiento

	if OptionManager.flagMenuPausa or flagInteractuando:
		pass
	
	else :
		
		# Obtiene la dirección de entrada y maneja el movimiento/desaceleración
		var directionLateral = Input.get_axis("left", "right")
		var directionVertical = Input.get_axis("up", "down")
		
		
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
		
		if	directionLateral != 0:
			velocity.y = move_toward(velocity.y, 0, SPEED)
		 
		if directionVertical != 0:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
		# Cambia la dirección del sprite según la dirección que toma el personaje
		if directionLateral > 0:
			animated_sprite_2d.flip_h = false  # No voltear el sprite
		elif directionLateral < 0:
			animated_sprite_2d.flip_h = true  # Voltear el sprite horizontalmente
		
	#endregion
	
	
	
	
	
	
	
	# Mueve al personaje usando la física
	move_and_slide()
