extends TextureButton

@export var numero: String


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass




func _on_pressed():
	#emito la señal input_caja_fuerte creada en SignalBus y le mando un String
	if numero == "PASTILLAS":
		SignalBus.input_rejilla.emit()
	else:
		SignalBus.input_caja_fuerte.emit(numero)
	
	pass # Replace with function body.
