extends Node2D

@export var duration : float 
@onready var timer: Timer = $Timer

func start_dash(duration)->void:
	timer.wait_time = duration
	timer.start()
	timer.one_shot = false
