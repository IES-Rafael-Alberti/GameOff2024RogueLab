extends CanvasLayer

@onready var volume_master_slider: HSlider = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/VolumeMasterSlider
@onready var volume_music_slider: HSlider = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer2/VolumeMusicSlider
@onready var volume_sfx_slider: HSlider = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer3/VolumeSFXSlider
@onready var v_sync_check_button: CheckButton = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer4/VSyncCheckButton
@onready var language_menu: OptionButton = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer5/LanguageMenu

@onready var mano_abierta: Sprite2D = $manoAbierta
@onready var mano_cerrada: Sprite2D = $manoCerrada

func _process(delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		mano_cerrada.global_position = get_viewport().get_mouse_position() + Vector2(10, 10)
		mano_abierta.global_position = Vector2(-50, -50)
	else:
		mano_cerrada.global_position = Vector2(-50, -50)
		mano_abierta.global_position = get_viewport().get_mouse_position() + Vector2(10, 10)
	
	
	pass


func _on_back_button_pressed() -> void:
	CanvasManager.back_options_menu()
	pass # Replace with function body.

func _on_volume_master_slider_value_changed(value: float) -> void:
	OptionManager.volumeMaster = value
	pass # Replace with function body.


func _on_volume_music_slider_value_changed(value: float) -> void:
	OptionManager.volumeMusic=value
	pass # Replace with function body.


func _on_volume_sfx_slider_value_changed(value: float) -> void:
	OptionManager.volumeSFX = value
	pass # Replace with function body.


func _on_v_sync_check_button_toggled(toggled_on: bool) -> void:
	OptionManager.vsync=toggled_on
	pass # Replace with function body.


func _ready() -> void:
	
	volume_master_slider.value=OptionManager.volumeMaster
	volume_music_slider.value=OptionManager.volumeMusic
	volume_sfx_slider.value=OptionManager.volumeSFX
	language_menu.select(OptionManager.languageId)
	v_sync_check_button.flat=OptionManager.vsync
	
	pass


func _on_lenguage_menu_item_selected(index: int) -> void:
	
	OptionManager.languageId = index
	
	pass # Replace with function body.
