extends Node

var player
const JUGADOR = preload("res://scenes/jugador.tscn")

var initSpeed = 130

#variables
var flag1 = false
var flag2 = false
var flag3 = false
var flag4 = false
var flag5 = false






# Called when the node enters the scene tree for the first time.
func _ready():
	player = JUGADOR.instantiate()
	player.SPEED = initSpeed
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
