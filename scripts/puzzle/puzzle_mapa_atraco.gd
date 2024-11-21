extends CanvasLayer

@export var event_id = ""

@export var distanciaDeInteraccion: float = 50

const PUZLE_ATRACO = preload("res://assets/sprites/Puzles/puzle_atraco/puzle_atraco.png")


@export var event_id=""

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
	
	#region condiciones del completado
	if not condiciones.has(false):  # Verifica que no haya ningún `false`
		print("¡Todas las condiciones son verdaderas!")
		complete()
		
		
		
		
	#endregion
	
	
	#region colocacion
	#posiciona las piezzas en su sitio correspondiente
	for i in piezas.size():
		var pieza = piezas[i]
		var marker = markers[i]
		
		
		# Verifica si la pieza no está siendo presionada y está cerca del marcador
		if not pieza.pesionando and pieza.global_position.distance_to(marker.global_position - (Vector2(pieza.size*pieza.scale / 2))) < distanciaDeInteraccion:
			pieza.global_position = marker.global_position - (Vector2(pieza.size*pieza.scale / 2))
			condiciones[i] = true
			print("Pieza %d colocada correctamente" % (i + 1))
		else:
			condiciones[i] = false
	#endregion
	
func complete():
	
		SignalBus.zoom_item.emit(PUZLE_ATRACO,200,4,100)
