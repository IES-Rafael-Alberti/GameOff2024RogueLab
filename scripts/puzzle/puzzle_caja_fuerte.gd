extends CanvasLayer

@onready var resultado = $resultado
@export var tamanioCodigo: int = 4


# Called when the node enters the scene tree for the first time.
func _ready():
	
	#conecto la señal creada en SignalBus.gd a la funcion _on__pressed
	SignalBus.input_caja_fuerte.connect(_on__pressed) 
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(resultado.text)
	pass




func _on__pressed(numero):
	print(numero)
	if resultado.text.length() == tamanioCodigo:
		pass
	else:
		resultado.text += numero
#
