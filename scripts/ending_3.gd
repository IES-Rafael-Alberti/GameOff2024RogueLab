extends CanvasLayer

@export var event_id=""
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.play_credits.connect(animacion)
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	pass

func animacion():
	animation_player.play("creditos")
	pass


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	TransitionScreen.transition()
	await SignalBus.on_transition_finished
	SignalBus.puzzle_exit.emit(self,false)
	GameManager.ending=true
	SignalBus.ending_info.emit(GameManager.get_event("Ev_Ending_03")[OptionManager.language])
	pass # Replace with function body.
