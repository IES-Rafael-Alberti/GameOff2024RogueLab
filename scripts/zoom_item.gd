extends CanvasLayer

@onready var texture_item: TextureRect = $PanelContainer/TextureRect

var textures = {
	"Foto_2":"res://assets/sprites/Puzles/puzle4_fotos/foto_personajes_disuminada_mario.png",
	"Foto_1":"res://assets/sprites/Puzles/puzle4_fotos/foto_personajes_disuminada_francesco.png",
	"Cuadro_Fran":"res://assets/sprites/Puzles/puzle4_fotos/foto_fran_pequeño.png",
	"Cuadro_Mario":"res://assets/sprites/Puzles/puzle4_fotos/foto_mario_pequeño.png",
	"Cuadro_Roto":"res://assets/sprites/Puzles/puzle4_fotos/foto_rota.png",
	"Cuadro_Atras":"res://assets/sprites/Puzles/puzle4_fotos/foto_rota_trasera.png",
	"Foto_Juntos":"res://assets/sprites/Puzles/puzle4_fotos/foto_personajes_disuminada_completar.png",
	"Mapa_Atraco":"res://assets/sprites/Puzles/puzle_atraco/puzle_atraco.png",
	"Llave":"res://assets/sprites/Puzles/Puzle1-llave/llave-puzle-1.png",
	"DNI":"res://assets/sprites/Escenario/DNI.png",
	"Pistola":"res://assets/sprites/Puzles/puzle_caja_fuerte/pistola_dinero.png",
	"Destornillador":"res://assets/sprites/Puzles/puzle2-rejilla/destornillador.png",
	"Codigo":"res://assets/sprites/Puzles/puzle_caja_fuerte/post-it.png",
	"Pastillas":"res://assets/sprites/Puzles/puzle2-rejilla/pastillas64x64.png"
}

var textureName
var textureMinSize
var textureMaxSize
var speed
var waiting

func _ready() -> void:
	
	SignalBus.zoom_item.connect(_zoom_item_execute)
	#SignalBus.wait_input.connect(_on_input_recieved)
	SignalBus.exit_zoom_item.connect(_on_exit_zoom_item)
	pass

func _process(delta: float) -> void:
	if GameManager.zoomItem:
		if texture_item.custom_minimum_size.x < textureMaxSize:
			texture_item.custom_minimum_size.x+=delta*speed
			texture_item.custom_minimum_size.y+=delta*speed
			
		#else :
			#print("animationFinished")
	#elif GameManager.zoomItem and waiting:
	#	GameManager.zoomItem=false
	#	hide()
	pass

func _zoom_item_execute(textureName,textureMaxSize,textureMinSize,speed):
	show()
	GameManager.zoomItem=true
	GameManager.zoomItemName=textureName
	var texture:String = textures.get(textureName)
	self.texture_item.texture = load(texture)
	self.textureName=textureName
	self.textureMaxSize=textureMaxSize
	self.textureMinSize=textureMinSize
	self.texture_item.custom_minimum_size.x = textureMinSize
	self.texture_item.custom_minimum_size.y = textureMinSize
	self.speed=speed
	pass


func _on_exit_zoom_item(zoomItemName):
	print("exit zoom item")
	GameManager.zoomItem=false
	GameManager.zoomItemName=""
	hide()
	SignalBus.zoom_item_closed.emit(zoomItemName)
	pass

#func _on_input_recieved():
	#if GameManager.zoomItem :
		#if GameManager.DialogVisible:
			#if texture_item.custom_minimum_size.x >= textureMaxSize:
				
				#GameManager.player.required=true
				#SignalBus.exit_zoom_item.emit(texture_item.texture)
