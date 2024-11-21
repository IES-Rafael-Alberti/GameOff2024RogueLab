extends CharacterBody2D
# variables

var required

# variables para diseñador
@export var SPEED = 130
@export var numFotosObtenidas = 0

# Variables para nodos
@onready var animated_sprite_2d = $AnimatedSprite2D  # Nodo para el sprite animado del personaje

func _ready() -> void:
	
	SignalBus.input_required.connect(_on_input_required)
	
	pass

#apartado de fisicas
func _physics_process(delta):

	#region menu de pausa
	
	if Input.is_action_just_pressed("escape"):
		if CanvasManager.inPause:
			CanvasManager.inPause = false
			CanvasManager.play_resume_pause_menu()
			print("MenuPausa: " + str(CanvasManager.inPause) )
		else:
			CanvasManager.inPause = true
			CanvasManager.play_pause_menu()
			print("MenuPausa: " + str(CanvasManager.inPause))

	#endregion

	#region interaccion
		
	if !CanvasManager.inPause and Input.is_action_just_pressed("interaccion"):	
		
		if required:
			required=false
			SignalBus.wait_input.emit()
		pass
	
	#endregion

	#region movimiento

	if (GameManager.puzzleLayer!=null or GameManager.DialogVisible) or CanvasManager.inPause:
		velocity.x=0
		velocity.y=0
		pass
	
	else :
		
			
		# Obtiene la dirección de entrada y maneja el movimiento/desaceleración
		var direccionHorizontal = Input.get_axis("left", "right")
		var directionVertical = Input.get_axis("up", "down")
		var ultima_direccion
		
		#print("vertical: "+str(directionVertical))
		#print("horizontal: "+str(direccionHorizontal))
		
			
		# Registra la última entrada cuando se detecta un cambio en alguna dirección
		if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
			ultima_direccion = "horizontal"
		elif Input.is_action_pressed("up") or Input.is_action_pressed("down"):
			ultima_direccion = "vertical"

		# Controla el movimiento basado en la última dirección de entrada
		if ultima_direccion == "horizontal":
			# Si la última entrada fue horizontal, mueve solo en el eje X
			if direccionHorizontal != 0:
				if direccionHorizontal > 0: #el if este esta implementado por el movimiento con el joistic
					velocity.x = 1 * SPEED
				else:
					velocity.x = -1 * SPEED
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED)
			# Desacelera el eje Y para mantener solo el movimiento en X
			velocity.y = move_toward(velocity.y, 0, SPEED)

		elif ultima_direccion == "vertical":
			# Si la última entrada fue vertical, mueve solo en el eje Y
			if directionVertical != 0:
				if directionVertical > 0: #el if este esta implementado por el movimiento con el joistic
					velocity.y = 1 * SPEED
				else:
					velocity.y = -1 * SPEED
			else:
				velocity.y = move_toward(velocity.y, 0, SPEED)
			
			# Desacelera el eje X para mantener solo el movimiento en Y
			velocity.x = move_toward(velocity.x, 0, SPEED)
			
		
		if direccionHorizontal == 0 and directionVertical == 0:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.y = move_toward(velocity.y, 0, SPEED)
		
		
		
		#region control de animaciones de movimiento
		
		if directionVertical == 0 and direccionHorizontal == 0:
			animated_sprite_2d.play("idle")
		elif ultima_direccion == "horizontal":
			animated_sprite_2d.play("walk")
			# Cambia la dirección del sprite según la dirección que toma el personaje
			if direccionHorizontal > 0:
				animated_sprite_2d.flip_h = true  # No voltear el sprite
			elif direccionHorizontal < 0:
				animated_sprite_2d.flip_h = false  # Voltear el sprite horizontalmente
		
		elif ultima_direccion == "vertical":
			animated_sprite_2d.play("walkFront")
		
		
		#endregion
		
		
		
	#endregion
	
	
	# Mueve al personaje usando la física
	move_and_slide()


func  _on_input_required():
	required=true
	pass
