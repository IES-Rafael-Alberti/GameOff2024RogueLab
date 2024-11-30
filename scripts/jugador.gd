extends CharacterBody2D
# variables

var required
var estado:String = ""

# variables para diseñador
@export var SPEED = 130
@export var numFotosObtenidas = 0

# Variables para nodos
@onready var animated_sprite_2d = $AnimatedSprite2D  # Nodo para el sprite animado del personaje

@onready var hud: TextureRect = $HUD


@onready var animation_tree: AnimationTree = $AnimationTree


func _ready() -> void:
	
	SignalBus.input_required.connect(_on_input_required)
	animation_tree.active=true
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
		
	if !CanvasManager.inPause and !GameManager.ending and !GameManager.transicion and Input.is_action_just_pressed("interaccion"):	
		
		
		if GameManager.DialogVisible or GameManager.puzzleLayer!=null or GameManager.zoomItem or required:
			SignalBus.wait_input.emit()
		
		#if required:
		#	required=false
		#	SignalBus.wait_input.emit()
		#pass
	
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
					estado = "Right"
				else:
					velocity.x = -1 * SPEED
					estado = "Left"
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED)
			# Desacelera el eje Y para mantener solo el movimiento en X
			velocity.y = move_toward(velocity.y, 0, SPEED)

		elif ultima_direccion == "vertical":
			# Si la última entrada fue vertical, mueve solo en el eje Y
			if directionVertical != 0:
				#print(directionVertical)
				if directionVertical > 0: #el if este esta implementado por el movimiento con el joistic
					velocity.y = 1 * SPEED
					estado = "Down" 
				else:
					velocity.y = -1 * SPEED
					estado = "UP"
			else:
				velocity.y = move_toward(velocity.y, 0, SPEED)
			
			# Desacelera el eje X para mantener solo el movimiento en Y
			velocity.x = move_toward(velocity.x, 0, SPEED)
			
		
		if direccionHorizontal == 0 and directionVertical == 0:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.y = move_toward(velocity.y, 0, SPEED)
		
		
		
		#region control de animaciones de movimiento
		
	update_state_animation()
		
		
		#
		#
		#
		#if directionVertical == 0 and direccionHorizontal == 0:
			#if estado == "UP":
				#animated_sprite_2d.play("idleUp")
			#elif estado ==  "Down":
				#animated_sprite_2d.play("idleDown")
			#elif estado ==  "Right":
				#animated_sprite_2d.play("idleRight")
			#elif estado ==  "Left":
				#animated_sprite_2d.play("idleLeft")
			#else:
				#animated_sprite_2d.play("idleDown")
		#elif ultima_direccion == "horizontal":
			#animated_sprite_2d.play("walk")
			## Cambia la dirección del sprite según la dirección que toma el personaje
			#if direccionHorizontal > 0:
				#animated_sprite_2d.flip_h = true  # No voltear el sprite
			#elif direccionHorizontal < 0:
				#animated_sprite_2d.flip_h = false  # Voltear el sprite horizontalmente
		#
		#elif ultima_direccion == "vertical":
			#if directionVertical > 0:
				#animated_sprite_2d.play("walkFront")
			#elif directionVertical < 0:
				#animated_sprite_2d.play("WalkUp")
		
		#endregion
		
		
		
	#endregion
	
	
	# Mueve al personaje usando la física
	move_and_slide()

func update_state_animation():
	
	if velocity == Vector2.ZERO:
		#idle
		animation_tree.set("parameters/blend_position",1)
		update_direction_animation()
	else:
		#walk
		animation_tree.set("parameters/blend_position",0)
		update_direction_animation()
		pass
	
	pass

func update_direction_animation():
	print(animation_tree.get("parameters/0/blend_position"))
	if estado == "UP":
		animation_tree.set("parameters/0/blend_position",Vector2.DOWN)
		animation_tree.set("parameters/1/blend_position",Vector2.DOWN)
		pass
	elif estado == "Down":
		animation_tree.set("parameters/0/blend_position",Vector2.UP)
		animation_tree.set("parameters/1/blend_position",Vector2.UP)
		pass
	elif  estado == "Left":
		animation_tree.set("parameters/0/blend_position",Vector2.LEFT)
		animation_tree.set("parameters/1/blend_position",Vector2.LEFT)
		pass
	elif estado == "Right":
		animation_tree.set("parameters/0/blend_position",Vector2.RIGHT)
		animation_tree.set("parameters/1/blend_position",Vector2.RIGHT)
		pass
	pass

func  _on_input_required():
	required=true
	pass
	
func hideHUD():
	
	hud.hide()
	
	pass	
	
func showHUD():
	
	hud.show()
	
	pass
