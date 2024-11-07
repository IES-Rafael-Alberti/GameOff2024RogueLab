extends Control

var glitch_tv_effect:bool 
var vignet_effect:bool
var vignet_effect_amount:int
var glow_effect:bool
var black_and_white_effect:bool

var current_menu
var pause_menu

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
	current_menu="MAIN_MENU"
	get_tree().change_scene_to_packed(MAIN_MENU)
	pass

func play_pause_menu():
	current_menu="PAUSE_MENU"
	
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
	get_tree().change_scene_to_packed(OPTION_MENU)
	pass
	
	
func play_current_menu():
	if current_menu == "MAIN_MENU":
		play_main_menu()
	elif  current_menu == "PAUSE_MENU":
		play_pause_menu()
	pass

func play_main_scene():
	get_tree().change_scene_to_packed(MAIN_SCENE)
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
