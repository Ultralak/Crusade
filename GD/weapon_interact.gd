extends Interactable

var is_on_ground : bool = true
var player : Character
func _ready() -> void:
	player = PlayerManager.player

func interact():
	pass
