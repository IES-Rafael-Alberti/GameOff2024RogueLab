extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	SignalBus.execute_canvas_option.connect(_on_canvas_option_recieved)
	
	
	pass # Replace with function body.


func _on_canvas_option_recieved(canvas_option):
	var shaderLayer = get_node_or_null(canvas_option)
	if shaderLayer == null:
		for i in get_children():
			i.hide()
			pass
		
	else:
		shaderLayer.show()
	pass
