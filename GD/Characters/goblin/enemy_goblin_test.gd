extends Label

@export var healthcomp : HealthComponent





func _process(_delta: float) -> void:
	var health : String = "Health : %s" % [healthcomp.health]
	text = health
