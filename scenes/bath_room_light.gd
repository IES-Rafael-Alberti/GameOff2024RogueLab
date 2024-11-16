extends Node

var shaderNode

func _ready() -> void:
	shaderNode = get_node("BathRoomShader")
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	shaderNode.hide()
	pass # Replace with function body.


func _on_area_2d_body_exited(body: Node2D) -> void:
	shaderNode.show()
	pass # Replace with function body.
