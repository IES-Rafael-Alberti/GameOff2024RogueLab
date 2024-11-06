extends CharacterBody2D

#variables
var DIRECCION = 1

# variables para diseñador
@export var VELOCIDAD = 60

# Variables para nodos que se usarán en el script
@onready var ray_cast_derecha = $RayCastDerecha
@onready var ray_cast_izquierda = $RayCastIzquierda
@onready var animated_sprite_2d = $AnimatedSprite2D


# Se llama cada cuadro. 'delta' es el tiempo transcurrido desde el cuadro anterior.
func _process(delta):
	
	# cambia direccion y sprite cuando vaya a colisionar usando raycast
	if ray_cast_derecha.is_colliding():
		DIRECCION = -1
		animated_sprite_2d.flip_h = true
	if ray_cast_izquierda.is_colliding():
		DIRECCION = 1
		animated_sprite_2d.flip_h = false
	
	# mueve al personaje
	position.x += DIRECCION * VELOCIDAD * delta

# se ejecuta al colisionar con otro objeto
func _on_area_2d_body_entered(body):
	
	# efectos que pasa si colisiona con el jugador
	if body.name == "jugador":
		# si tine mas de 1 de vida entra
		if	body.vida >1: # resta 1 de vida y actualiza la informacion
			body.decrementa_una_vida() 
		else: # si no tiene mas dde 1 de vida muere
			body.death()
