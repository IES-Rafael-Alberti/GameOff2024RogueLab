extends Node
 
var player:CharacterBody2D
const JUGADOR = preload("res://scenes/jugador.tscn")
var soundWhisper: AudioStreamOggVorbis = load("res://Sound Effects/whispers-14814.ogg")
var whisper: AudioStreamPlayer2D

var initSpeed = 130
var interactive:Node2D
var isTrigger:bool

var codigoCajaFuerte:String = "1904"

#variables
var evento
var ItemMaxScale
var ItemMinScale
var ItemSpeed

var zoomItemName:String=""
var zoomItem:bool=false
var DialogVisible:bool=false
var puzzleLayer:CanvasLayer=null

#variables objetos
var key:bool=false
var screwdriver:bool=false
var dni:bool=false
var postIt:bool=false

#variable de puzzles
var rejilla:bool
var foto_encimera:bool

var foto_estanteria:bool
var mapa:bool
var caja_fuerte:bool

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GameManager.puzzleLayer != null and !CanvasManager.inPause:
		DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_HIDDEN)
	else:
		DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_VISIBLE)
	pass

func _ready() -> void:
	SignalBus.execute_event.connect(_on_event_execute)
	SignalBus.wait_input.connect(_on_input_recived)
	SignalBus.puzzle_enter.connect(_setPuzzleLayer)
	SignalBus.puzzle_exit.connect(_exitPuzzle)
	SignalBus.zoom_item_closed.connect(_on_zoom_out)
	
	whisper = AudioStreamPlayer2D.new()
	whisper.stream = soundWhisper
	add_child(whisper)
	pass

func _setPuzzleLayer(puzzleLayer: CanvasLayer):
	self.puzzleLayer = puzzleLayer
	pass
	
func _exitPuzzle(puzzleLayer):
	if self.puzzleLayer==puzzleLayer:
		self.puzzleLayer=null
	pass

func get_player():
	if(player == null):
		player = JUGADOR.instantiate()
		player.SPEED = initSpeed
		player.position.y+=45
	
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
		player.hideHUD()
	else:
		interactive=body
		eventHandler()
		player.showHUD()
	
func get_event_from_interactive():
	
	#Buscar evento en csv
	evento = DataManager.scriptData.get(interactive.event_id)
	
	pass
	
func get_event(event_id):
	return DataManager.scriptData.get(event_id)
	pass

func go_to_next():
	SignalBus.event_waiting.emit(evento["NEXT"])
	if evento["NEXT"]!="":
		eventHandler()
	
	
func _on_event_execute(event_id,aux):
	if !DialogVisible:

		print("Ejecutando evento: "+event_id)
			#Configuracion Shaders y Camera
			
		
			

		if aux:
			var aux_event = get_event(event_id)
			#Dependiendo del idioma ES o EN
			SignalBus.execute_dialog.emit(aux_event[OptionManager.language], event_id)
			
			if aux_event["EVENT_CONDITION"] == "PUZZLE":
				print("puzzle entrando")
				player.required=true
				SignalBus.execute_puzzle.emit(event_id)
				pass
			
		else:	
				#Si es puzzle ejecutar puzzle
			if evento["EVENT_CONDITION"] == "PUZZLE":
				print("puzzle entrando")
				player.required=true
				SignalBus.execute_puzzle.emit(event_id)
				pass
			
			SignalBus.execute_dialog.emit(evento[OptionManager.language], event_id)
			
		
		
		
	pass

func restartVariables():
	#variables objetos
	key=false
	screwdriver=false
	dni=false
	postIt=false
#variable de puzzles
	rejilla=false
	foto_encimera=false
	foto_estanteria=false
	mapa=false
	caja_fuerte=false
	puzzleLayer=null
	setInteractive(null)
	DataManager.reloadData()
	print("Resetear variables")
	pass

func _on_input_recived():
	if !DialogVisible and puzzleLayer==null and !zoomItem:
		if interactive!=null and !isTrigger:
			interactive.on_triggered()
			pass
		pass
	
	if !zoomItem and interactive!=null and interactive.event_id!="":
		if interactive.event_id == "Ev_Corpse_02":
			print("Llave")
			#ItemTexture=preload( "res://assets/sprites/Puzles/Puzle1-llave/llave-puzle-1.png")
			ItemMaxScale=64*3
			ItemMinScale=64
			ItemSpeed=150
			SignalBus.zoom_item.emit("Llave",ItemMaxScale,ItemMinScale,ItemSpeed)
			key=true
		elif interactive.event_id == "Ev_Screwdriver_02":
			print("Destornillador")
			#ItemTexture=preload("res://assets/sprites/Puzles/destornillador.png")
			ItemMaxScale=64*3
			ItemMinScale=64
			ItemSpeed=150
			SignalBus.zoom_item.emit("Destornillador",ItemMaxScale,ItemMinScale,ItemSpeed)
			screwdriver=true
		elif interactive.event_id == "Ev_FirstCode":
			print("PostIt")
			#ItemTexture=preload("res://assets/sprites/Puzles/caja fuerte/post-it.png")
			ItemMaxScale=64*3
			ItemMinScale=64
			ItemSpeed=150
			SignalBus.zoom_item.emit("Codigo",ItemMaxScale,ItemMinScale,ItemSpeed)
			postIt=true
		elif interactive.event_id == "Ev_DNI" or interactive.event_id == "Ev_DNIBefore":
			print("DNI")
			if mapa and foto_encimera and foto_estanteria:
				evento["NEXT"] = "Ev_DNIAfter"
				
			else:
				evento["NEXT"] = "Ev_DNIBefore"
		elif interactive.event_id == "Ev_DNIAfter":
			print("Ev_DNIAfter")
			#ItemTexture=preload("res://assets/sprites/Escenario/DNI.png")
			ItemMaxScale=64*3
			ItemMinScale=64
			ItemSpeed=150
			SignalBus.zoom_item.emit("DNI",ItemMaxScale,ItemMinScale,ItemSpeed)
			dni=true
		elif interactive.event_id == "Ev_BrokenPicture":
			print("Ev_BrokenPicture")
			if GameManager.key and !GameManager.foto_encimera:
				ItemMaxScale=64*3
				ItemMinScale=64
				ItemSpeed=150
				#Evento de encimera
				if !foto_estanteria:
					#Primera
					evento["NEXT"] = "Ev_FirstBrokenPicture_01"
				else:
					#Segunda
					evento["NEXT"] = "Ev_SecondBrokenPicture_01"
					SignalBus.zoom_item.emit("Foto_2",ItemMaxScale,ItemMinScale,ItemSpeed)
					print("Foto whisper")
					whisper.play()
				foto_encimera=true
		elif interactive.event_id == "Ev_FirstBrokenPicture_01":
			SignalBus.zoom_item.emit("Foto_1",ItemMaxScale,ItemMinScale,ItemSpeed)
		elif interactive.event_id == "Ev_SecondBrokenPicture_01":
			SignalBus.zoom_item.emit("Foto_2",ItemMaxScale,ItemMinScale,ItemSpeed)
			print("Foto whisper")
			whisper.play()
		elif interactive.event_id == "Ev_Table":
			if key:
				evento["NEXT"] = "Ev_Blueprint_01"
		elif interactive.event_id == "Ev_Closet":
			if GameManager.dni:
				evento["NEXT"] = "Ev_FirstWardrobe"
			else:
				evento["NEXT"] = "Ev_Closet"
				
		elif interactive.event_id == "Ev_Drawer":
			if GameManager.caja_fuerte:
				evento["NEXT"]="Ev_Screwdriver_02"
		elif interactive.event_id == "Ev_Shelve_02":
			if GameManager.key:
				evento["NEXT"]="Ev_Shelve"
		elif interactive.event_id == "Ev_Door_02":
			if GameManager.key:
				evento["NEXT"]="Ev_Door_03"
		elif interactive.event_id == "Ev_Door_03":
			if GameManager.key and !dni:
				evento["NEXT"]="Ev_Ending_01"
			elif GameManager.key and dni:
				evento["NEXT"]="Ev_Ending_02"
	pass
	
func _on_zoom_out(texture):	
	if texture == "Foto_2":
		print("Ya tienes las 2 fotos")
		SignalBus.zoom_item.emit("Foto_Juntos",900,100,1000)
		SignalBus.execute_event.emit("Ev_SecondBrokenPicture_03",true)
		
	pass
