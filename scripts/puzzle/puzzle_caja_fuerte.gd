extends CanvasLayer
@onready var pistola = $pistola
@export var event_id = ""
@onready var CFpistola = $cajaFuerteAbierta/pistola
@onready var caja_fuerte_abierta = $cajaFuerteAbierta
@onready var resultado = $resultado
@export var tamanioCodigo: int = 4
var codigo: String = "1234" #cambiar por codigo de game manager

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#conecto la señal creada en SignalBus.gd a la funcion _on__pressed
	SignalBus.input_caja_fuerte.connect(_on__pressed) 
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(resultado.text)
	pass



#funcion para cada tecla
func _on__pressed(character):
	print(character)
	if character == "EXIT":#recarga el resultado
		resultado.text = ""
	elif character == "ENTER":#comprueva el resultado
		comprobarCodigo(resultado.text)
	elif character == "PISTOLA":#interactua con la pistola
		CFpistola.queue_free()#eliminamos el boton
		SignalBus.zoom_item.emit(preload("res://icon.svg"),200,4,100)
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
		_on__pressed("EXIT")
