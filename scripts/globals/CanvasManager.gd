extends Control

var glitch_tv_effect:bool 
var vignet_effect:bool
var vignet_effect_amount:int
var glow_effect:bool
var black_and_white_effect:bool

var inGame:bool=false
var pause_menu
var option_menu

const MAIN_MENU = preload("res://scenes/menus/main_menu.tscn")
const PAUSE_MENU = preload("res://scenes/menus/pause_menu.tscn")
const OPTION_MENU = preload("res://scenes/menus/option_menu.tscn")

const MAIN_SCENE= preload("res://scenes/prueva_movimiento.tscn")

func set_glitch_effect(action:bool):
	glitch_tv_effect=action
	pass
	
func set_vignet_effect(action:bool,amount:bool):
	vignet_effect=action
	vignet_effect_amount=amount
	pass

func set_glow_effect(action:bool):
	glow_effect=action
	pass

func set_black_and_white_effect(action:bool):
	black_and_white_effect=action
	pass

func _ready() -> void:
	play_main_menu()
	pass

func play_main_menu():
	get_tree().change_scene_to_packed(MAIN_MENU)
	pass

func play_pause_menu():
	
	if pause_menu == null:
		pause_menu = PAUSE_MENU.instantiate()
		get_tree().current_scene.add_child(pause_menu)
		pass
	
	pause_menu.visible=true
	
	#cambiar escena de pausa completamente
	#get_tree().change_scene_to_packed(PAUSE_MENU)
	pass
	
func play_resume_pause_menu():
	pause_menu.visible=false 
	
func play_options_menu():
	
	if option_menu == null:
		option_menu = OPTION_MENU.instantiate()
		get_tree().current_scene.add_child(option_menu)
		option_menu.get_parent().move_child(option_menu,1)
	
	option_menu.visible = true
	
	if(inGame):
		if(pause_menu.visible):
			pause_menu.visible = false
	else:
		get_tree().get_first_node_in_group("MainMenu").visible = false
	
	
	pass

func back_options_menu():
	
	if(option_menu.visible):
		option_menu.visible=false
		if(inGame):
			pause_menu.visible=true
		else:
			get_tree().get_first_node_in_group("MainMenu").visible = true
		pass
	

func play_main_scene():
	get_tree().change_scene_to_packed(MAIN_SCENE)
	inGame=true
	pass

func _process(delta: float) -> void:
	
	if(glitch_tv_effect):
		pass
	
	if(vignet_effect):
		pass
		
	if(glow_effect):
		pass
	
	if(black_and_white_effect):
		pass
	
	
	pass
