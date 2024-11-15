extends Node
 
var player:CharacterBody2D
const JUGADOR = preload("res://scenes/jugador.tscn")

var initSpeed = 130
var interactive:Node2D

#variables

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _ready() -> void:
	SignalBus.execute_event.connect(_on_event_execute)
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
	var evento = DataManager.scriptData.get(event_id)
	
	if evento == null:
		print("Clave de evento no encontrada")
	else:
			# ejecutar opciones canvas
		SignalBus.execute_canvas_option.emit(evento["SHADER_OPTIONS"])
			# ejecutar opciones camara
		SignalBus.execute_camera_option.emit(evento["CAMERA_OPTIONS"])
		
		SignalBus.execute_dialog.emit(evento["ES"])
		
		if evento["NEXT"] != "":
		
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
