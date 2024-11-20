extends CanvasLayer

@onready var texture_item: TextureRect = $PanelContainer/TextureRect

var textureMinSize
var textureMaxSize
var speed
var waiting

func _ready() -> void:
	
	SignalBus.zoom_item.connect(_zoom_item_execute)
	SignalBus.wait_input.connect(_on_input_recieved)
	pass

func _process(delta: float) -> void:
	if GameManager.zoomItem and !waiting:
		if texture_item.custom_minimum_size.x < textureMaxSize:
			texture_item.custom_minimum_size.x+=delta*speed
			texture_item.custom_minimum_size.y+=delta*speed
		else :
			SignalBus.input_required.emit()
			print("animationFinished")
			waiting=true
	pass

func _zoom_item_execute(texture,textureMaxSize,textureMinSize,speed):
	show()
	GameManager.zoomItem=true
	self.textureMaxSize=textureMaxSize
	self.textureMinSize=textureMinSize
	self.texture_item.texture=texture
	self.texture_item.custom_minimum_size.x = textureMinSize
	self.texture_item.custom_minimum_size.y = textureMinSize
	self.speed=speed
	waiting=false
	pass

func _on_input_recieved():
	if GameManager.zoomItem and !GameManager.DialogVisible and waiting:
		if texture_item.custom_minimum_size.x >= textureMaxSize:
			GameManager.zoomItem=false
			hide()
			GameManager.player.required=true
	pass
