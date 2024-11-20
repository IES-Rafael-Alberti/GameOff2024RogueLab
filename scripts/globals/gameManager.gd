extends Node
 
var player:CharacterBody2D
const JUGADOR = preload("res://scenes/jugador.tscn")

var initSpeed = 130
var interactive:Node2D
var isTrigger:bool

#variables
var evento

var ItemTexture
var ItemMaxScale
var ItemMinScale
var ItemSpeed


var zoomItem:bool=false
var DialogVisible:bool=false
var puzzleLayer:CanvasLayer=null

#variables objetos
var key:bool=false
var screwdriver:bool=false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _ready() -> void:
	SignalBus.execute_event.connect(_on_event_execute)
	SignalBus.wait_input.connect(_on_input_recived)
	SignalBus.puzzle_enter.connect(_setPuzzleLayer)
	SignalBus.puzzle_exit.connect(_exitPuzzle)
	pass

func _setPuzzleLayer(puzzleLayer: CanvasLayer):
	self.puzzleLayer = puzzleLayer
	pass
	
func _exitPuzzle():
	self.puzzleLayer=null
	pass

func get_player():
	
	if(player == null):
		player = JUGADOR.instantiate()
		player.SPEED = initSpeed
		player.position.y+=50
	
	return player

func eventHandler():
	
	get_event_from_interactive()
	if evento !=null:
		#Si es trigger saltar automaticamente
		if evento["EVENT_CONDITION"] == "TRIGGER":
			isTrigger=true
			player.required=false
			interactive.on_triggered()
			#go_to_next()
			pass
		#Si no es trigger, esperar interaccion
		elif evento["EVENT_CONDITION"] == "NONE" or evento["EVENT_CONDITION"] == "PUZZLE":
			isTrigger=false
			SignalBus.input_required.emit()
			pass
		pass
	else:
		print("Evento no encontrado")
		pass
	pass
	
	pass

func setInteractive(body:Node2D):
	if body==null:
		player.required=false
		interactive=null
	else:
		interactive=body
		eventHandler()
	
func get_event_from_interactive():
	
	#Buscar evento en csv
	evento = DataManager.scriptData.get(interactive.event_id)
	
	pass
	
func go_to_next():
	SignalBus.event_waiting.emit(evento["NEXT"])
	if evento["NEXT"]!="":
		eventHandler()
	
	
func _on_event_execute(event_id):
	
	if !DialogVisible:

		print("Ejecutando evento: "+event_id)
			#Configuracion Shaders y Camera
			
		#Si es puzzle ejecutar puzzle
		if evento["EVENT_CONDITION"] == "PUZZLE":
			SignalBus.execute_puzzle.emit()
			pass
			
		#Dependiendo del idioma ES o EN
		SignalBus.execute_dialog.emit(evento["ES"])
	
	pass

func _on_input_recived():
	if !DialogVisible and puzzleLayer==null and !zoomItem:
		if interactive!=null and !isTrigger:
			interactive.on_triggered()
			pass
		pass
	
	if !zoomItem:
		if interactive.event_id == "Ev_Corpse2":
			print("Llave")
			ItemTexture=preload( "res://assets/sprites/Puzles/Puzle1-llave/llave-puzle-1.png")
			ItemMaxScale=64*3
			ItemMinScale=64
			ItemSpeed=150
			SignalBus.zoom_item.emit(ItemTexture,ItemMaxScale,ItemMinScale,ItemSpeed)
			key=true
		elif interactive.event_id == "TXT_TEST_2" and key:
			print("Sal")
			pass
		
	pass
