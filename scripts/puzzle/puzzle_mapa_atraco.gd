extends CanvasLayer

@export var distanciaDeInteraccion: float = 50

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

# Lógica principal
func _process(delta: float) -> void:
	for i in piezas.size():
		var pieza = piezas[i]
		var marker = markers[i]
		
		# Verifica si la pieza no está siendo presionada y está cerca del marcador
		if not pieza.pesionando and pieza.global_position.distance_to(marker.global_position) < distanciaDeInteraccion:
			pieza.global_position = marker.global_position
			print("Pieza %d colocada correctamente" % (i + 1))
