extends Area2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func examinarFoto(numFotosObtenidas: int) -> int:
	
	print("Parece la mitad de una foto")
	if numFotosObtenidas<1:
		#(se muestra la encimera de cerca con un trozo de foto)
		print("Parece que alguien la ha roto por la mitad")
		numFotosObtenidas +=1
		#(al salir de la vista habiendo encontrado el trozo de foto)
		print("La otra mitad debe estar por aquí.")
		
		return numFotosObtenidas
		
	else:
		#(se muestra la encimera de cerca con un trozo de foto)
		print("Esta parece la otra mitad de la foto.")
		numFotosObtenidas += 1
		#(al salir de la vista habiendo encontrado el trozo de foto, se muestran juntos los 2 trozos)
		print("Ese tal Mario, lleva la misma ropa que yo... -Él y Francesco parecen cercanos.")
		
		return numFotosObtenidas




func _on_body_entered(body: Node2D) -> void:
	if body.name == "jugador":
		body.interactionObject = self
		print("objeto entregado")
		
	if body.flagInteractuando:
		examinarFoto(body.numFotosObtenidas)
