extends Node
 
var player:CharacterBody2D
const JUGADOR = preload("res://scenes/jugador.tscn")

var initSpeed = 130
var interactive:Node2D


#variables
var flagList: Array[Flag] = [] 
##Cargar todas las flags en la lista 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_player():
	
	if(player == null):
		player = JUGADOR.instantiate()
		player.SPEED = initSpeed
	
	return player
	pass

func setInteractive(body:Node2D):
	interactive=body
