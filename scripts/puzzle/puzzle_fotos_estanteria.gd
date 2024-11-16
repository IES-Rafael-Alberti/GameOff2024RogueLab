extends CanvasLayer

const FOTO_MARIO_PEQUE_O = preload("res://assets/sprites/Puzles/puzle4_fotos/foto_mario_pequeño.png")
const FOTO_ROTA = preload("res://assets/sprites/Puzles/puzle4_fotos/foto_rota.png")
const FOTO_FRAN_PEQUE_O = preload("res://assets/sprites/Puzles/puzle4_fotos/foto_fran_pequeño.png")

@export var event_id=""

func _ready() -> void:
	
	pass 



func _on_francesco_foto_button_pressed() -> void:
	print("Francesco")
	SignalBus.zoom_item.emit(FOTO_FRAN_PEQUE_O,1200,100,1000)
	pass 



func _on_mario_foto_button_pressed() -> void:
	print("Mario")
	SignalBus.zoom_item.emit(FOTO_MARIO_PEQUE_O,1200,100,1000)
	pass 



func _on_foto_rota_button_pressed() -> void:
	print("Rota")
	SignalBus.zoom_item.emit(FOTO_ROTA,1200,100,1000)
	pass 
