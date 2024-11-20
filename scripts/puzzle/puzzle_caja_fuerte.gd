extends CanvasLayer

@onready var resultado = $resultado
@export var tamanioCodigo: int = 4
var codigo: String = "1234" #cambiar por codigo de game manager

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#conecto la señal creada en SignalBus.gd a la funcion _on__pressed
	SignalBus.input_caja_fuerte.connect(_on__pressed) 
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(resultado.text)
	



#funcion para cada tecla
func _on__pressed(numero):
	print(numero)
	if numero == "EXIT":#recarga el resultado
		resultado.text = ""
	elif numero == "ENTER":#comprueva el resultado
		comprobarCodigo(resultado.text)
	elif resultado.text.length() >= tamanioCodigo:#comprueva k no supere el limite
		pass
	else:
		resultado.text += numero

#si el codigo es el correcto puesta la siguiente imagen #falta hacer
func comprobarCodigo(resultado: String):
	if resultado == codigo:
		print("conseguido")#cambiar
		
	else:
		print("Intentalo de nuevo")
		_on__pressed("EXIT")
