extends Node
 
var player:CharacterBody2D
const JUGADOR = preload("res://scenes/jugador.tscn")

var initSpeed = 100
var interactive:Node2D

var evento
var event_id

var ItemTexture
var ItemMaxScale
var ItemMinScale
var ItemSpeed


var zoomItem:bool=false

#variables
var key:bool=false
var startEvent:bool=false




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _ready() -> void:
	SignalBus.execute_event.connect(_on_event_execute)
	SignalBus.wait_input.connect(_on_input_recived)
	pass

func get_player():
	
	if(player == null):
		player = JUGADOR.instantiate()
		player.position.y = player.position.y+50
		player.SPEED = initSpeed
	
	return player

func setInteractive(body:Node2D):
	interactive=body
	
func _on_event_execute(event_id):
	print("Ejecutando evento: "+event_id)
	#Buscar evento en csv
	self.event_id=event_id
	evento = DataManager.scriptData.get(event_id)
	
	if evento == null:
		print("Clave de evento no encontrada")
	else:
			# ejecutar opciones canvas
		SignalBus.execute_canvas_option.emit(evento["SHADER_OPTIONS"])
			# ejecutar opciones camara
		SignalBus.execute_camera_option.emit(evento["CAMERA_OPTIONS"])
		
		SignalBus.execute_dialog.emit(evento["ES"])
		
		
		
		if evento["NEXT"] != "":
			SignalBus.input_required.emit()
		
			if evento["EVENT_CONDITION"] == "PUZZLE":
				# si ejecuta puzles mandar "next" al puzle para que pueda continuar el arbol
				SignalBus.execute_puzzle.emit(event_id)
				pass
			elif evento["EVENT_CONDITION"] == "TRIGGER":
				# si depende de un trigger mandar al trigger "next" esperarlo
				SignalBus.event_waiting.emit(evento["NEXT"])
				pass
			elif evento["EVENT_CONDITION"] == "NONE":
				# si no tiene señal de puzle ni de triger ejecuta la siguiente escena 
				
					pass
				
		else:
				# si no tiene next finaliza esa rama de dialogo
			SignalBus.event_waiting.emit("")
			pass
	

			
		
	
	pass
func _on_input_recived():
	if !zoomItem:
		if event_id == "Ev_Corpse2":
			print("Llave")
			ItemTexture= preload("res://assets/sprites/Puzles/Puzle1-llave/llave-puzle-1.png")
			ItemMaxScale=64*3
			ItemMinScale=64
			ItemSpeed=150
			SignalBus.zoom_item.emit(ItemTexture,ItemMaxScale,ItemMinScale,ItemSpeed)
			key=true
		elif event_id == "TXT_TEST_2" and key:
			print("Sal")
			pass
			
		if evento["EVENT_CONDITION"] == "PUZZLE":
			# si ejecuta puzles mandar "next" al puzle para que pueda continuar el arbol
			SignalBus.execute_puzzle.emit(event_id)
			pass
		elif evento["EVENT_CONDITION"] == "TRIGGER":
				# si depende de un trigger mandar al trigger "next" esperarlo
			SignalBus.event_waiting.emit(evento["NEXT"])
			pass
		elif evento["EVENT_CONDITION"] == "NONE":
		# si no tiene señal de puzle ni de triger ejecuta la siguiente escena 
			pass
	pass
