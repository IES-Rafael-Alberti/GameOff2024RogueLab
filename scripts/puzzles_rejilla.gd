extends CanvasLayer
@onready var rejilla_sin_pastis: Sprite2D = $"Rejilla-sin-pastis"

@onready var rejilla_sin_tornillos = $"Rejilla-sin-tornillos"
@onready var pastillasButton = $"Rejilla-sin-pastis/pastillas"
const PASTILLAS_64X_64 = preload("res://assets/sprites/Puzles/puzle2-rejilla/pastillas64x64.png")

@export var event_id=""
@export var event_id_screwdriver=""
@export var	event_id_pastillas=""

var mostrar1=true

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
	SignalBus.wait_input.connect(_on_input_recived)
	SignalBus.puzzle_enter.connect(_on_puzzle_enter)
#funcion para cada tecla


func _on_puzzle_enter(puzzleLayer):
	if puzzleLayer==self:
		mostrar1=true
	
	pass

func _on__pressed(character):
	print(character)
	if character == "PASTILLAS":#recarga el resultado
		pastillasButton.queue_free()
		GameManager.rejilla = true
		SignalBus.zoom_item.emit(PASTILLAS_64X_64,200,4,100)
		SignalBus.execute_event.emit(event_id_pastillas,true)

func _on_input_recived():
	if GameManager.puzzleLayer==self :
		if !GameManager.DialogVisible and !GameManager.zoomItem:
			SignalBus.puzzle_exit.emit(self)
	pass
	
func comprobarTornillos():
	if tornillosQuitados == 4:
		rejilla_sin_pastis.visible = true
		rejilla_sin_tornillos.queue_free()
		#rejilla_sin_tornillos_existe = false
		#print("rejilla_sin_tornillos: " + str(rejilla_sin_tornillos_existe))
		
func _process(delta: float) -> void:
	if GameManager.puzzleLayer == self:
		if !GameManager.rejilla:
			if  !GameManager.zoomItem and !GameManager.DialogVisible  and mostrar1 :
				
				if GameManager.screwdriver:
					SignalBus.execute_event.emit(event_id_screwdriver,true)
				mostrar1=false
			
			pass
			if !GameManager.DialogVisible and !GameManager.zoomItem:
				
				SignalBus.input_required.emit()
				
				pass 
		
