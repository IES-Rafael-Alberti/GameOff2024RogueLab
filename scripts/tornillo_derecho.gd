extends Sprite2D
@onready var animation_player = $AnimationPlayer

#eliminar esto
@onready var scene_rejilla = $"../.."

# Variable para almacenar si el clic izquierdo se ha realizado
var clicked_left: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass  # Aquí puedes poner algo que quieras hacer al iniciar

# Detectar entrada del ratón (clic izquierdo)
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and get_global_mouse_position().distance_to(global_position) < 20.0:
		print("clikIzquierdo")  # Si se hace clic izquierdo
		if event.pressed and get_global_mouse_position().distance_to(global_position) < 20.0:
			clicked_left = true  # Cambia el estado a true al hacer clic
			print("Clic izquierdo detectado")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if clicked_left and not animation_player.is_playing(): #if clicked_left and GameManager.destornillador:  # Verifica que GameManager.flag1 esté activado
		clicked_left = false
		animation_player.play("rotar")  # Activa la animación llamada "rotar"
		
		print("animacionejecutada")
		#await animation_player.finished
		  # Restablece el estado después de iniciar la animación
		#queue_free()
	
	pass
	



func _on_animation_player_animation_finished(anim_name):
	scene_rejilla.tornillosQuitados += 1
	print("tornillos quitados: "+str(scene_rejilla.tornillosQuitados))
	
	queue_free() # Replace with function body.
