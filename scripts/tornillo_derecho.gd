extends Sprite2D
@onready var animation_player = $AnimationPlayer

# Variable para almacenar si el clic izquierdo se ha realizado
var clicked_left: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass  # Aquí puedes poner algo que quieras hacer al iniciar

# Detectar entrada del ratón (clic izquierdo)
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		print("clikIzquierdo")  # Si se hace clic izquierdo
		if event.pressed and get_global_mouse_position().distance_to(global_position) < 20.0:
			clicked_left = true  # Cambia el estado a true al hacer clic
			print("Clic izquierdo detectado")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if clicked_left :  # Verifica que GameManager.flag1 esté activado
		animation_player.play("rotar")  # Activa la animación llamada "rotar"
		await animation_player.animation_finished
		print("animacionejecutada")
		#await animation_player.finished
		clicked_left = false  # Restablece el estado después de iniciar la animación
		queue_free()
	
	pass
