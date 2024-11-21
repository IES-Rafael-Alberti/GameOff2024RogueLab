extends TextureButton
@onready var animation_player = $AnimationPlayer

#eliminar esto
@onready var puzzle_rejilla = $"../.."

# Called when the node enters the scene tree for the first time.
func _ready():
	pass  # Aquí puedes poner algo que quieras hacer al iniciar

func _on_pressed() -> void:
	print("Pressed")
	if GameManager.screwdriver == true:
		animation_player.play("rotar")
		
	else:
		print("No tengo destornillador")
	pass

func _on_animation_player_animation_finished(anim_name):
	puzzle_rejilla.tornillosQuitados += 1
	puzzle_rejilla.comprobarTornillos()
	print("tornillos quitados: "+str(puzzle_rejilla.tornillosQuitados))
	
	queue_free() # Replace with function body.
