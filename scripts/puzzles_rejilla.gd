extends CanvasLayer
@onready var rejilla_sin_pastis: Sprite2D = $"Rejilla-sin-pastis"

@onready var rejilla_sin_tornillos = $"Rejilla-sin-tornillos"
@onready var pastillasButton = $"Rejilla-sin-pastis/pastillas"
@onready var screwdriver2D: Sprite2D = $screwdriver
@onready var mano_abierta = $manoAbierta
@onready var mano_cerrada = $manoCerrada

var screwdriverMouse = false
#const PASTILLAS_64X_64 = preload("res://assets/sprites/Puzles/puzle2-rejilla/pastillas64x64.png")

@export var event_id=""
@export var event_id_screwdriver=""
@export var	event_id_pastillas=""
@export var event_ending_3=""

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
	SignalBus.exit_zoom_item.connect(_on_zoom_item_exit)
#funcion para cada tecla

func _on_zoom_item_exit(zoomItemName):
	
	if GameManager.rejilla and zoomItemName == "Pastillas":
		SignalBus.puzzle_exit.emit(self)
		TransitionScreen.transition()
		await SignalBus.on_transition_finished
		SignalBus.execute_event.emit(event_ending_3,true)
		print("Tas pasao el juego crack")
		#print(GameManager.evento)
		#print(GameManager.interactive.event_id)
		pass
	
	pass

func _on_puzzle_enter(puzzleLayer):
	if puzzleLayer==self:
		mostrar1=true
	
	pass

func _on__pressed():
	#print(character)
	pastillasButton.queue_free()
	GameManager.rejilla = true
	SignalBus.zoom_item.emit("Pastillas",200,4,100)
	SignalBus.execute_event.emit(event_id_pastillas,true)
	
	
	
	#if character == "PASTILLAS":#recarga el resultado
	#if pastillasButton == null:
		#pass
	#else character == "PASTILLAS":#recarga el resultado
		#pastillasButton.queue_free()
		#GameManager.rejilla = true
		#SignalBus.zoom_item.emit(PASTILLAS_64X_64,200,4,100)
		#SignalBus.execute_event.emit(event_id_pastillas,true)

func _on_input_recived():
	if GameManager.puzzleLayer==self :
		if !GameManager.DialogVisible and !GameManager.zoomItem:
			SignalBus.puzzle_exit.emit(self)
	pass
	
func comprobarTornillos():
	if tornillosQuitados == 4:
		screwdriverMouse  = false
		rejilla_sin_pastis.visible = true
		if rejilla_sin_tornillos == null:
			pass
		else:
			rejilla_sin_tornillos.queue_free()
		#rejilla_sin_tornillos_existe = false
		#print("rejilla_sin_tornillos: " + str(rejilla_sin_tornillos_existe))
		
func _process(delta: float) -> void:
	if GameManager.puzzleLayer == self:
		if !GameManager.rejilla:
			if  !GameManager.zoomItem and !GameManager.DialogVisible  and mostrar1 :
				
				if GameManager.screwdriver:
					screwdriverMouse  = true
					comprobarTornillos()
					SignalBus.execute_event.emit(event_id_screwdriver,true)
					mostrar1=false
			
			pass
			if !GameManager.DialogVisible and !GameManager.zoomItem:
				
				SignalBus.input_required.emit()
				
				pass 
	
	
	if screwdriverMouse:
			screwdriver2D.global_position = get_viewport().get_mouse_position() + Vector2(40, -30)
			mano_abierta.global_position = Vector2(-50, -50)
			mano_cerrada.global_position = Vector2(-50, -50)
	else:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			screwdriver2D.global_position = Vector2(-50, -50)
			mano_cerrada.global_position = get_viewport().get_mouse_position() + Vector2(10, 10)
			mano_abierta.global_position = Vector2(-50, -50)
		else:
			screwdriver2D.global_position = Vector2(-50, -50)
			mano_cerrada.global_position = Vector2(-50, -50)
			mano_abierta.global_position = get_viewport().get_mouse_position() + Vector2(10, 10)
	
	
