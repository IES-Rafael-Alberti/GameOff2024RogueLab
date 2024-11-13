extends Node
 
var player:CharacterBody2D
const JUGADOR = preload("res://scenes/jugador.tscn")

var initSpeed = 130
var interactive:Node2D


#variables
var flagList: Array[Flag] = [] 
##Cargar todas las flags en la lista 

const ALL_FLAGS = preload("res://data/all_flags.tres")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _ready() -> void:
	ALL_FLAGS.load_all_into(flagList)
	for f in flagList:
		print(f.name.name)
func get_player():
	
	if(player == null):
		player = JUGADOR.instantiate()
		player.SPEED = initSpeed
	
	return player
	pass

func setInteractive(body:Node2D):
	interactive=body
