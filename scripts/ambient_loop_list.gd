extends Node

@export var limits: Vector2 = Vector2(0, 5)
@export var sounds: Array[AudioStreamOggVorbis]

@onready var timer = $Timer
@onready var audio = $AudioStreamPlayer2D


@onready var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	random_timer()

func random_timer():
	audio.stream = sounds[rng.randi_range(0, sounds.size()-1)]
	#print(audio.stream)
	timer.wait_time = rng.randf_range(limits.x, limits.y)
	#print(timer.wait_time)
	timer.start()


func _on_timer_timeout() -> void:
	audio.play()
	# wait for audio finished signal
	await audio.finished
	random_timer()
