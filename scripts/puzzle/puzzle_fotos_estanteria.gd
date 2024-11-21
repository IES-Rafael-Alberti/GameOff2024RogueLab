extends CanvasLayer

const FOTO_MARIO_PEQUE_O = preload("res://assets/sprites/Puzles/puzle4_fotos/foto_mario_pequeño.png")
const FOTO_ROTA = preload("res://assets/sprites/Puzles/puzle4_fotos/foto_rota.png")
const FOTO_FRAN_PEQUE_O = preload("res://assets/sprites/Puzles/puzle4_fotos/foto_fran_pequeño.png")

var canExit=true

@export var event_id=""

@export var event_id_foto_fran=""
@export var event_id_foto_mario=""
@export var event_id_foto_rota=""

func _ready() -> void:
	SignalBus.wait_input.connect(_on_input_recieved)
	SignalBus.exit_zoom_item.connect(_on_zoom_out)
	pass 

func _on_zoom_out(texture):
	canExit=true
	
	pass

func _on_francesco_foto_button_pressed() -> void:
	print("Francesco")
	SignalBus.zoom_item.emit(FOTO_FRAN_PEQUE_O,900,100,1000)
	SignalBus.execute_event.emit(event_id_foto_fran,true)
	pass 



func _on_mario_foto_button_pressed() -> void:
	print("Mario")
	SignalBus.zoom_item.emit(FOTO_MARIO_PEQUE_O,900,100,1000)
	SignalBus.execute_event.emit(event_id_foto_mario,true)
	pass 



func _on_foto_rota_button_pressed() -> void:
	print("Rota "+event_id)
	SignalBus.zoom_item.emit(FOTO_ROTA,900,100,1000)
	SignalBus.execute_event.emit(event_id_foto_rota,true)
	#SignalBus.execute_event.emit(DataManager.scriptData.get(event_id_foto_rota)["NEXT"])
	
	pass 

func _on_input_recieved():
	if GameManager.puzzleLayer==self :
		if !GameManager.DialogVisible and !GameManager.zoomItem:
			SignalBus.puzzle_exit.emit(self)
	pass
