extends CanvasLayer

@onready var texture_item: TextureRect = $PanelContainer/TextureRect

var textureMinSize
var textureMaxSize
var speed

func _ready() -> void:
	
	SignalBus.zoom_item.connect(_zoom_item_execute)
	SignalBus.wait_input.connect(_on_input_recieved)
	pass

func _process(delta: float) -> void:
	if GameManager.zoomItem:
		if texture_item.custom_minimum_size.x < textureMaxSize:
			texture_item.custom_minimum_size.x+=delta*speed
			texture_item.custom_minimum_size.y+=delta*speed
		else :
			SignalBus.input_required.emit()
	pass

func _zoom_item_execute(texture,textureMaxSize,textureMinSize,speed):
	show()
	GameManager.zoomItem=true
	texture_item.texture = texture
	self.textureMaxSize=textureMaxSize
	self.textureMinSize=textureMinSize
	self.speed=speed
	pass

func _on_input_recieved():
	if GameManager.zoomItem:
		if texture_item.custom_minimum_size.x >= textureMaxSize:
			GameManager.zoomItem=false
			hide()
	pass
