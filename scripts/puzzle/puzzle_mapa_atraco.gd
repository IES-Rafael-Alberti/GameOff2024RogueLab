extends CanvasLayer

@export var event_id = ""

@export var distanciaDeInteraccion: float = 50
@export var animTamanioMax = 1000
@export var animTamanioMin = 4
@export var animVelocidad = 300



const PUZLE_ATRACO = preload("res://assets/sprites/Puzles/puzle_atraco/puzle_atraco.png")

# Arrays para las piezas y sus marcadores correspondientes
@onready var piezas: Array = [
	$piezas/EsquinaSuperiorHizquierda,
	$piezas/EsquinaSuperiorDerecha,
	$piezas/EsquinaInferiorDerecha,
	$piezas/EsquinaInferiorHizquierda,
	$piezas/Superior,
	$piezas/Inferior,
	$piezas/Centro
]

@onready var markers: Array = [
	$piezas/Marker2DEsquinaSuperiorHizquierda,
	$piezas/Marker2DEsquinaSuperiorDerecha,
	$piezas/Marker2DEsquinaInferiorDerecha,
	$piezas/Marker2DEsquinaInferiorHizquierda,
	$piezas/Marker2DSuperior,
	$piezas/Marker2DInferior,
	$piezas/Marker2DCentro
]

#array de afirmaciones de colocaciones
var condiciones: Array = [
	false,
	false,
	false,
	false,
	false,
	false,
	false
]

# Lógica principal
func _process(delta: float) -> void:
	
	pass

#se ejecuta cuando se completa el puzzle
func complete():
	GameManager.mapa = true
	SignalBus.zoom_item.emit(PUZLE_ATRACO,animTamanioMax,animTamanioMin,animVelocidad)


#te debuelve el marcador correspondiente a la piezza
func comprobarMarcador(body: TextureButton) -> int: 
	
	var num = 0
	
	for i in piezas.size():
			if piezas[i] == body:
				num = i
	return num
	
#comprueva si esta la pieza en su sitio
func comprobarPosicion(body: TextureButton, num: int):
	#region colocacion
	
	var marker = markers[num]
	
	
	# Verifica si la pieza no está siendo presionada y está cerca del marcador
	if body.global_position.distance_to(marker.global_position - (Vector2(body.size*body.scale / 2))) < distanciaDeInteraccion:
		body.global_position = marker.global_position - (Vector2(body.size*body.scale / 2))
		condiciones[num] = true
		print("Pieza %d colocada correctamente" % (num + 1))
		
		#region condiciones del completado
		if not condiciones.has(false):  # Verifica que no haya ningún `false`
			print("¡Todas las condiciones son verdaderas!")
			complete()
			
		#endregion
	else:
		condiciones[num] = false
		#endregion
	
