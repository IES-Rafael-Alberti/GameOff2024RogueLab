extends Area2D

# variables  para el diseñador
@export var distancia_recorrido_animacion = 60
@export var duracion_recorrido_animacion = 1

# Variables para nodos que se usarán en el script
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var sonido_moneda = $sonidoMoneda
@onready var collision_shape_2d = $CollisionShape2D
@onready var moneda = $"."

# se ejecuta al colisionar con otro objeto
func _on_body_entered(body):
	if	body.name == "jugador":
		body.incrementa_numMonedas() # actualiza la puntuacion
		sonido_moneda.play() # Reproduce el sonido de obtencion de moneda
		collision_shape_2d.call_deferred("set", "disabled", true) # desactiva la colision de manera segura al finalizar el fotograma actual.
		destruction_animated() # Funcion para destruirse con una animacion
	
	else:
		pass

# se ejecuta cuando finaliza el sonido de la moneda
func _on_sonido_moneda_finished():
	queue_free() # Destruye la moneda

# Función que controla la animacion al destruirse
func destruction_animated():

	# Crea un nuevo tween (animación) dentro del árbol de nodos, lo asocia al nodo "moneda" y configura para que las animaciones puedan correr en paralelo
	var tween = get_tree().create_tween().bind_node(moneda).set_parallel(true)

	# Define una animación de movimiento para la propiedad "position" del nodo "moneda":
	# - La moverá hacia arriba (usando Vector2.UP) una distancia igual a `distancia_recorrido_animacion`
	# - Con una duración de `duracion_recorrido_animacion`
	# - Aplica una transición Sine Out (acelera al inicio y desacelera al final)
	tween.tween_property(moneda, "position", moneda.position + Vector2.UP * distancia_recorrido_animacion, duracion_recorrido_animacion).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

	# Define una animación de desvanecimiento en el color (self_modulate) de "animated_sprite_2d":
	# - Cambia su color de opacidad desde completo (1) hasta transparente (0)
	# - Con una duración de `duracion_recorrido_animacion`
	tween.tween_property(animated_sprite_2d, "self_modulate", Color(Color.WHITE, 0), duracion_recorrido_animacion)

	# Espera a que el tween (la animación) termine antes de continuar
	await tween.finished

	# Una vez terminada la animación, libera (elimina) el nodo "moneda" de la escena
	moneda.queue_free()



