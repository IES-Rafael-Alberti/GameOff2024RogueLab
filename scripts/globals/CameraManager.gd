extends Node

var NoiseCamera:bool
var NoiseIntensitty:float

var OffsetX:float
var OffsetY:float

var Camera:Camera2D

func add_camera(player:CharacterBody2D):
	
	if(Camera == null):
		Camera = Camera2D.new()
	
	player.add_child(Camera)
	
	pass

func tweenCameraBetween(offsetX:float,offsetY:float,tweenTime:float):
	
	
	
	pass

func _process(delta: float) -> void:
	
	if NoiseCamera:
		pass
	
	pass
