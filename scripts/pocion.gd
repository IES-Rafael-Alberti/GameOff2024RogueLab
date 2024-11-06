extends Area2D

# Variables para nodos que se usarán en el script
@onready var game_manager = %GameManager
@onready var sonido_pocion = $sonidoPocion
@onready var sprite_2d = $Sprite2D
@onready var collision_shape_2d = $CollisionShape2D

# se ejecuta al colisionar con otro objeto
func _on_body_entered(body):
	if	body.name == "jugador":
		body.incrementa_una_vida() # actualiza la vida
		sonido_pocion.play() # Reproduce el sonido de obtencion de pocion
		sprite_2d.visible= false # se deja de visualizar la pocion
		collision_shape_2d.call_deferred("set", "disabled", true) # desactiva la colision de manera segura al finalizar el fotograma actual.
		
	else:
		pass
	
# se ejecuta cuando finaliza el sonido de la pocion
func _on_sonido_pocion_finished():
	queue_free() # Destruye la pocion
