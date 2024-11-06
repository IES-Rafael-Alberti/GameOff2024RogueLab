extends Area2D

# Ruta de la escena a la que quieres cambiar (ajusta el path según tu proyecto)


# Se ejecuta cuando otro cuerpo (body) entra en el área del portal
func _on_body_entered(body):
	print("entraste")
	# Verifica si el body que ha entrado es el jugador
	if body.name == "jugador":  # Cambia "jugador" por el nombre del nodo de tu jugador si es distinto
		print("fifififififi")
		get_tree().change_scene_to_file("res://scenes/Tutorial2.tscn")  # Cambia a la nueva escena
