extends CanvasLayer
@onready var pistola = $pistola
@onready var mano: Sprite2D = $mano

#const PISTOLA_DINERO = preload("res://assets/sprites/Puzles/caja fuerte/pistola_dinero.png")

@export var event_id = ""
@onready var CFpistola = $cajaFuerteAbierta/pistola
@onready var caja_fuerte_abierta = $cajaFuerteAbierta
@onready var resultado = $resultado
@export var tamanioCodigo: int = 4

@export var event_id_success=""
@export var event_id_failure=""

var codigo: String = GameManager.codigoCajaFuerte
var onceProcess = false
# Called when the node enters the scene tree for the first time.
func _ready():
	
	#conecto la señal creada en SignalBus.gd a la funcion _on__pressed
	SignalBus.input_caja_fuerte.connect(_on__pressed) 
	SignalBus.wait_input.connect(_on_input_recived)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	mano.global_position = get_viewport().get_mouse_position()
	
	if GameManager.puzzleLayer==self:
		if !GameManager.DialogVisible and !GameManager.zoomItem and !onceProcess:
			onceProcess=true
			SignalBus.input_required.emit()
	
	


func _on_input_recived():
	if GameManager.puzzleLayer==self:
		if !GameManager.DialogVisible and !GameManager.zoomItem:
			SignalBus.puzzle_exit.emit(self)
	pass


#funcion para cada tecla
func _on__pressed(character):
	print(character)
	if character == "EXIT":#recarga el resultado
		resultado.text = ""
	elif character == "ENTER":#comprueva el resultado
		comprobarCodigo(resultado.text)
	elif character == "PISTOLA":#interactua con la pistola
		SignalBus.execute_event.emit(event_id_success,true)
		CFpistola.queue_free()#eliminamos el boton
		GameManager.caja_fuerte = true
		onceProcess=false
		SignalBus.zoom_item.emit("Pistola",200,4,100)
		#pistola.visible = true#muestra la puistola obtenida
		##fin de scene
	elif resultado.text.length() >= tamanioCodigo:#comprueva k no supere el limite
		pass
	else:
		resultado.text += character
		


#si el codigo es el correcto puesta la siguiente imagen #falta hacer
func comprobarCodigo(resultado: String):
	if resultado == codigo:
		caja_fuerte_abierta.visible = true
		print("conseguido")
	else:
		print("Intentalo de nuevo")
		SignalBus.execute_event.emit(event_id_failure,true)
		onceProcess=false
		_on__pressed("EXIT")
