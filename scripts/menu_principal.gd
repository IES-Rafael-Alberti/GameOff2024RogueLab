extends CanvasLayer


# variables para rutas de escenas
var escena1 = "res://scenes/Tutorial1.tscn"
var escena2 = "res://scenes/Tutorial2.tscn"

# funcion para el boton escena1
func _on_escena_1_pressed():
	get_tree().change_scene_to_file(escena1)

# funcion para el boton escena2
func _on_escena_2_pressed():
	get_tree().change_scene_to_file(escena2)

# funcion para el boton exit
func _on_exit_pressed():
	get_tree().quit()
