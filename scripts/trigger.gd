
extends Marker2D

@export var event_id:String = ""
@onready var trigger_inicio: Marker2D = $"../TriggerInicio"

@export var isTriggered:bool = false


func _ready() -> void:
	SignalBus.event_waiting.connect(_on_event_wating)
	
	pass 


func _process(delta: float) -> void:
	
	pass

func on_triggered():
	if(event_id!=""):
		SignalBus.execute_event.emit(event_id)		
	pass

func _on_event_wating(event_id:String):
	if GameManager.interactive==self:
		if event_id != "":
			self.event_id=event_id
		else :
			self.queue_free()
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	#if GameManager.startEvent == false and isTriggered == true:
	#		GameManager.setInteractive(self)
	#		on_triggered()
	#		GameManager.startEvent = true
			

	if GameManager.player == body and GameManager.interactive==null:
		GameManager.setInteractive(self)
	
	pass 


func _on_area_2d_body_exited(body: Node2D) -> void:
	if GameManager.player == body and GameManager.interactive==self:
		GameManager.setInteractive(null)
	#	if isTriggered:
	#		if trigger_inicio != null:
	#			trigger_inicio.queue_free()
	pass 
