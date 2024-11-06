extends RigidBody2D

#variables
var direction = 0

# variables para diseñador
@export var force = 100

# Se llama cuando el nodo ingresa al árbol de escena por primera vez.
func _ready():
	
	#da un nimpulso en la direccion a la que se mira con una fuerza
	apply_central_impulse(Vector2(direction,-1) * force) 

# se ejecuta al colisionar con otro objeto
func _on_body_entered(body):
	print("Colisión detectada con: ", body.name)
	
	queue_free()  # Destruye el proyectil
