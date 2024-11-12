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
		var direccionHorizontal = Input.get_axis("left", "right")
		var directionVertical = Input.get_axis("up", "down")
		var ultima_direccion
		
		print("vertical: "+str(directionVertical))
		print("horizontal: "+str(direccionHorizontal))
		
			
		# Registra la última entrada cuando se detecta un cambio en alguna dirección
		if Input.is_action_just_pressed("left") or Input.is_action_just_pressed("right"):
			ultima_direccion = "horizontal"
		elif Input.is_action_just_pressed("up") or Input.is_action_just_pressed("down"):
			ultima_direccion = "vertical"

		# Controla el movimiento basado en la última dirección de entrada
		if ultima_direccion == "horizontal":
			# Si la última entrada fue horizontal, mueve solo en el eje X
			if direccionHorizontal != 0:
				velocity.x = direccionHorizontal * SPEED
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED)
			# Desacelera el eje Y para mantener solo el movimiento en X
			velocity.y = move_toward(velocity.y, 0, SPEED)

		elif ultima_direccion == "vertical":
			# Si la última entrada fue vertical, mueve solo en el eje Y
			if directionVertical != 0:
				velocity.y = directionVertical * SPEED
			else:
				velocity.y = move_toward(velocity.y, 0, SPEED)
			
			# Desacelera el eje X para mantener solo el movimiento en Y
			velocity.x = move_toward(velocity.x, 0, SPEED)
			
		
		if direccionHorizontal == 0 and directionVertical == 0:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.y = move_toward(velocity.y, 0, SPEED)
		
		
		
		# Cambia la dirección del sprite según la dirección que toma el personaje
		if direccionHorizontal > 0:
			animated_sprite_2d.flip_h = false  # No voltear el sprite
		elif direccionHorizontal < 0:
			animated_sprite_2d.flip_h = true  # Voltear el sprite horizontalmente
		
	#endregion
	
	
	
	
	
	
	
	# Mueve al personaje usando la física
	move_and_slide()
