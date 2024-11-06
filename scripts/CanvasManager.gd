extends Control

var glitch_tv_effect:bool 
var vignet_effect:bool
var vignet_effect_amount:int

@onready var main_menu:Control
@onready var pause_menu:Control
@onready var option_menu:Control

func set_glitch_effect(action:bool):
	glitch_tv_effect=action
	pass
	
func set_vignet_effect(action:bool,amount:bool):
	vignet_effect=action
	vignet_effect_amount=amount
	pass

func play_main_menu():
	
	pass

func play_pause_menu():
	
	pass

func _process(delta: float) -> void:
	
	if(glitch_tv_effect):
		pass
	
	if(vignet_effect):
		pass
		
	
	
	
	pass
