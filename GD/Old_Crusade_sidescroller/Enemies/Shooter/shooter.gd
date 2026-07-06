extends Shooter

@export var attack_duration : float

var direction : int = 1


func _ready() -> void:
	EnemyHealthManager.update_dictionary(name , health)

func update_direction():
	direction *= -1
