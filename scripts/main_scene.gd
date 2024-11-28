extends Node2D

#@onready var foto_rota_encimera = $FotoRotaEncimera
#@onready var mapa_roto = $MapaRoto
#@onready var mapa_arreglado = $MapaArreglado




func _ready() -> void:
	var player=GameManager.get_player()
	
	get_tree().current_scene.add_child(player)
	CanvasManager.instanciate_dialog()
	
	
	#SignalBus.BrokenPicture.connect(eliminarFoto)
	#SignalBus.mapaMesa.connect(cambiarMapa)
	pass 

func eliminarFoto():
	#foto_rota_encimera.hide()
	pass
func cambiarMapa():
	#mapa_roto.hide()
	#mapa_arreglado.show()
	pass
