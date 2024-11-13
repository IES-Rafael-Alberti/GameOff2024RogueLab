
extends Marker2D

@export var event_id:String = ""

func _ready() -> void:
	SignalBus.event_waiting.connect(_on_event_wating)
	pass 


func _process(delta: float) -> void:
	pass

func on_triggered():
	if(event_id!=null):
		SignalBus.execute_event.emit(event_id)
	pass

func _on_event_wating(event_id:String):
	self.event_id = event_id
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if GameManager.player == body and GameManager.interactive==null:
		GameManager.setInteractive(self)
	
	pass 


func _on_area_2d_body_exited(body: Node2D) -> void:
	
	if GameManager.player == body:
		GameManager.setInteractive(null)
	
	pass 
