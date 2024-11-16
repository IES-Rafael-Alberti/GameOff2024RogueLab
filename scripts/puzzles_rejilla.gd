extends CanvasLayer

@onready var rejilla_sin_tornillos = $"Rejilla-sin-tornillos"
@onready var rejilla_sin_rejilla = $"Rejilla-sin-rejilla"
@onready var panel_container = $PanelContainer

@export var evento_id=""

#eliminar estos
var tornillosQuitados = 0
var pastillasQuitadas = 0

var rejilla_sin_tornillos_existe = true
var rejilla_sin_rejilla_existe = true
var pastillas = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if GameManager.screwdriver:
		pastillasQuitadas = 1
		print("pastillasQuitadas: " + str(pastillasQuitadas))
	
	if tornillosQuitados == 4 and rejilla_sin_tornillos_existe:#if GameManager.tornillosQuitados == 4:
		rejilla_sin_tornillos.queue_free()
		rejilla_sin_tornillos_existe = false
		print("rejilla_sin_tornillos: " + str(rejilla_sin_tornillos_existe))
	
	if pastillasQuitadas == 1 and rejilla_sin_rejilla_existe:#if GameManager.pastillasQuitadas == 1:
		rejilla_sin_rejilla.queue_free()
		rejilla_sin_rejilla_existe = false
		panel_container.visible = true
		print("rejilla_sin_rejilla: " + str(rejilla_sin_rejilla_existe))
		
	
