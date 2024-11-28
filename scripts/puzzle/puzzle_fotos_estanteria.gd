extends CanvasLayer

#const FOTO_MARIO_PEQUE_O = preload("res://assets/sprites/Puzles/puzle4_fotos/foto_mario_pequeño.png")
#const FOTO_ROTA = preload("res://assets/sprites/Puzles/puzle4_fotos/foto_rota.png")
#const FOTO_FRAN_PEQUE_O = preload("res://assets/sprites/Puzles/puzle4_fotos/foto_fran_pequeño.png")
#const FOTO_ROTA_TRASERA = preload("res://assets/sprites/Puzles/puzle4_fotos/foto_rota_trasera.png")
#const FOTO_PERSONAJES_DISUMINADA_MARIO = preload("res://assets/sprites/Puzles/puzle4_fotos/foto_personajes_disuminada_mario.png")
#const FOTO_PERSONAJES_DISUMINADA_FRANCESCO = preload("res://assets/sprites/Puzles/puzle4_fotos/foto_personajes_disuminada_francesco.png")
var canExit=true

@onready var fotos_estanterias_vacia: TextureRect = $FotosEstanteriasVacia240x135
@onready var trasera_button: TextureButton = $TextureButton
@onready var foto_oculta = $FotoOculta
@onready var esquina_rota = $EsquinaRota
@onready var foto_rota_button = $FotoRotaButton
@onready var mano: Sprite2D = $mano




@export var event_id=""

@export var event_id_foto_fran=""
@export var event_id_foto_mario=""
@export var event_id_foto_rota=""
@export var event_id_foto_rota_trasera=""
@export var event_id_recoger_foto1=""
@export var event_id_recoger_foto2=""
@export var event_id_fotos_juntas=""

func _ready() -> void:
	SignalBus.wait_input.connect(_on_input_recieved)
	SignalBus.exit_zoom_item.connect(_on_zoom_out)
	pass 

func _process(delta: float) -> void:

	mano.global_position = get_viewport().get_mouse_position()


func _on_zoom_out(texture):
	canExit=true
	pass

func _on_francesco_foto_button_pressed() -> void:
	print("Francesco")
	SignalBus.zoom_item.emit("Cuadro_Fran",900,100,1000)
	SignalBus.execute_event.emit(event_id_foto_fran,true)
	pass 



func _on_mario_foto_button_pressed() -> void:
	print("Mario")
	SignalBus.zoom_item.emit("Cuadro_Mario",900,100,1000)
	SignalBus.execute_event.emit(event_id_foto_mario,true)
	pass 



func _on_foto_rota_button_pressed() -> void:
	print("Rota "+event_id)
	SignalBus.zoom_item.emit("Cuadro_Roto",900,100,1000)
	SignalBus.execute_event.emit(event_id_foto_rota,true)
	#SignalBus.execute_event.emit(DataManager.scriptData.get(event_id_foto_rota)["NEXT"])
	
	pass 

func _on_input_recieved():
	if GameManager.puzzleLayer==self :
		if !GameManager.DialogVisible and !GameManager.zoomItem:
			SignalBus.puzzle_exit.emit(self)
	pass


func _on_esquina_rota_pressed() -> void:
	print("Rota trasera "+event_id)
	SignalBus.zoom_item.emit("Cuadro_Atras",900,100,1000)
	SignalBus.execute_event.emit(event_id_foto_rota,true)
	
	#trasera_button.show()
	foto_oculta.show()
	fotos_estanterias_vacia.show()
	esquina_rota.visible = false
	foto_rota_button.visible = false
	pass # Replace with function body.


func _on_trasera_button_pressed() -> void:
	pass

func _on_foto_oculta_pressed() -> void:
	print("Nueva foto obtenida "+event_id_foto_rota_trasera)
	#SignalBus.zoom_item.emit(FOTO_ROTA_TRASERA,900,100,1000)
	if !GameManager.foto_encimera:
		#Pimera
		SignalBus.zoom_item.emit("Foto_1",900,100,1000)
		SignalBus.execute_event.emit(event_id_recoger_foto1,true)
	else:
		#Segunda
		SignalBus.zoom_item.emit("Foto_2",900,100,1000)
		SignalBus.execute_event.emit(event_id_recoger_foto2,true)
	foto_oculta.visible = false
	GameManager.foto_estanteria = true
