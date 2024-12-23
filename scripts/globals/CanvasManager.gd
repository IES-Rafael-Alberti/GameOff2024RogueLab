extends Control

var glitch_tv_effect:bool 
var vignet_effect:bool=true
var vignet_effect_amount:int
var glow_effect:bool
var black_and_white_effect:bool

var inGame:bool=false
var inPause:bool=false

var pause_menu
var option_menu
var main_scene
var dialog_canvas
var ending_canvas

const MAIN_MENU = preload("res://scenes/UI/main_menu.tscn")
const PAUSE_MENU = preload("res://scenes/UI/pause_menu.tscn")
const OPTION_MENU = preload("res://scenes/UI/option_menu.tscn")

const DIALOGS = preload("res://scenes/UI/dialogs.tscn")
const ENDING = preload("res://scenes/Prefabs/Ending.tscn")

const MAIN_SCENE= preload("res://scenes/Principal.tscn")
const OPENING = preload("res://scenes/opening.tscn")

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
	#play_main_menu()
	pass

func play_main_menu():
	call_deferred("changeScene")
	pass

func changeScene():
	get_tree().change_scene_to_packed(MAIN_MENU)
	if inGame == true:
		inGame=false
		GameManager.restartVariables()
	pass

func play_pause_menu():
	
	if pause_menu == null:
		pause_menu = PAUSE_MENU.instantiate()
		get_tree().current_scene.add_child(pause_menu)
		pass
	
	pause_menu.visible=true
	pass

func instanciate_dialog():
	if dialog_canvas == null:
		dialog_canvas = DIALOGS.instantiate()
		get_tree().current_scene.add_child(dialog_canvas)
		pass
	dialog_canvas.hide()
	
func instantiate_ending():
	if ending_canvas == null:
		ending_canvas = ENDING.instantiate()
		get_tree().current_scene.add_child(ending_canvas)
		pass
	ending_canvas.hide()

func play_resume_pause_menu():
	pause_menu.visible=false 
	
func play_options_menu():
	
	if option_menu == null:
		option_menu = OPTION_MENU.instantiate()
		get_tree().current_scene.add_child(option_menu)
	option_menu.visible = true
	
	if(inGame):
		if(pause_menu!=null and  pause_menu.visible):
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
	

func play_opening():
	get_tree().change_scene_to_packed(OPENING)
	pass

func play_main_scene():
	var player = GameManager.get_player()
	CameraManager.add_camera(player)
	get_tree().change_scene_to_packed(MAIN_SCENE)
	inGame=true
	pass

func alternate_pause():
	
	if inGame:
		if inPause:
			play_resume_pause_menu()
			inPause=false
		else:
			play_pause_menu()
			inPause=true
	
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
