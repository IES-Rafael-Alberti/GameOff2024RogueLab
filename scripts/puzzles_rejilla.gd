extends CanvasLayer
@onready var rejilla_sin_pastis: Sprite2D = $"Rejilla-sin-pastis"

@onready var rejilla_sin_tornillos = $"Rejilla-sin-tornillos"
@onready var pastillasButton = $"Rejilla-sin-pastis/pastillas"
@onready var rejilla_sin_rejilla = $"Rejilla-sin-rejilla"
@onready var panel_container = $PanelContainer
const PASTILLAS_64X_64 = preload("res://assets/sprites/Puzles/puzle2-rejilla/pastillas64x64.png")
@export var event_id=""

var tornillosQuitados = 0

#eliminar estos
var pastillasQuitadas = 0

var rejilla_sin_tornillos_existe = true
var rejilla_sin_rejilla_existe = true
var pastillas = true

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#conecto la señal creada en SignalBus.gd a la funcion _on__pressed
	SignalBus.input_rejilla.connect(_on__pressed) 
	


#funcion para cada tecla
func _on__pressed(character):
	print(character)
	if character == "PASTILLAS":#recarga el resultado
		pastillasButton.queue_free()
		GameManager.rejilla = true
		SignalBus.zoom_item.emit(PASTILLAS_64X_64,200,4,100)
		
	

func comprobarTornillos():
	if tornillosQuitados == 4:
		rejilla_sin_pastis.visible = true
		rejilla_sin_tornillos.queue_free()
		#rejilla_sin_tornillos_existe = false
		#print("rejilla_sin_tornillos: " + str(rejilla_sin_tornillos_existe))
		
