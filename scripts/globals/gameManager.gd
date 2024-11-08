extends Node

var player:CharacterBody2D
const JUGADOR = preload("res://scenes/jugador.tscn")

var initSpeed = 130

#variables
var flag1 = false
var flag2 = false
var flag3 = false
var flag4 = false
var flag5 = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_player():
	
	if(player == null):
		player = JUGADOR.instantiate()
		player.SPEED = initSpeed
	
	return player
	pass
