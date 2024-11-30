
extends Marker2D

@export var event_id:String = ""

func _ready() -> void:
	SignalBus.event_waiting.connect(_on_event_wating)
	
	pass 

func on_triggered():
	if(event_id!=""):
		SignalBus.execute_event.emit(event_id,false)
		sounds()
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
		$"../../Sounds/Effects/Breaking News".stop()
	#	if isTriggered:
	#		if trigger_inicio != null:
	#			trigger_inicio.queue_free()
	pass 

func sounds():
	match event_id:
			"Ev_Fridge":
				print("Nevera")
				$"../../Sounds/Effects/FridgeSound".play()
			"Ev_Corpse_02":
				print("Llave")
				$"../../Sounds/Effects/Key".play()
				await $"../../Sounds/Effects/Key".finished
				$"../../Sounds/Effects/Knock".play()
			"Ev_02":
				print("Cuerpo")
				$"../../Sounds/Effects/Jumpscare".play()
			"Ev_02_TV_01":
				print("TV Noise")
				$"../../Sounds/Effects/TV".play()
			"Ev_02_TV_02":
				print("News")
				$"../../Sounds/Effects/TV".stop()
				$"../../Sounds/Effects/News Voice".play()
				$"../../Sounds/Effects/Breaking News".play()
			"Ev_02_TV_03":
				$"../../Sounds/Effects/News Voice".stop()
			"Ev_Door_03":
				print("Puerta abrir sonido")
				$"../../Sounds/Effects/Open door".play()
				$"../../Sounds/Ambience".stop()
				$"../../Sounds/Effects/Siren".play()
			"Ev_DNIAfter":
				print("DNI Sound")
				$"../../Sounds/Effects/Paper".play()
				await $"../../Sounds/Effects/Paper".finished
				$"../../Sounds/Effects/Knock".play()
				await $"../../Sounds/Effects/Knock".finished
				$"../../Sounds/Horror".play()
			_:
				print("Not case")	
