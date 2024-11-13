
extends Marker2D

@export var CameraShader: ShaderMaterial
@export_multiline var DialogText: String
@export var PuzzleName:String
@export var flagsList:Array[FlagName]

@export var ModifiedFlag:Flag

##Cargar una lista de todas las flags en un mapa con un booleano

func _ready() -> void:
	
	pass 


func _process(delta: float) -> void:
	pass

func on_triggered():
	
	for flag in flagsList:
		if GameManager.flagList.has(flag):
			pass
	
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	
	if GameManager.player == body and GameManager.interactive==null:
		GameManager.setInteractive(self)
	
	pass 


func _on_area_2d_body_exited(body: Node2D) -> void:
	
	if GameManager.player == body:
		GameManager.setInteractive(null)
	
	pass 
