extends Area2D


# se ejecuta al colisionar con otro objeto
func _on_body_entered(body):
	
	# efectos que pasa si colisiona con el jugador
	if body.name == "jugador":
		body.death()
	




