extends CharacterBody2D
@export var timer : Timer
@export var disapear_time : float

func _ready() -> void:
	timer.wait_time = disapear_time
	timer.one_shot = true
	timer.start()
	timer.timeout.connect(on_timeout)
	
func on_timeout()->void:
	call_deferred("queue_free")
