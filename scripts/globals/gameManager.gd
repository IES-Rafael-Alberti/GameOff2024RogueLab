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
		SignalBus.event_waiting.emit(evento["NEXT"])

	# ejecutar opciones canvas
	# ejecutar opciones camara
	# si ejecuta puzles mandar "next" al puzle para que pueda continuar el arbol
	# si depende de un trigger mandar al trigger "next" esperarlo
	# si no tiene señal de puzle ni de triger ejecuta la siguiente escena 
	# si no tiene next finaliza esa rama de dialogo
	
	pass
