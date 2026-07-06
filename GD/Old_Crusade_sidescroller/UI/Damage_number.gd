extends Label

var max_health : String
var health : String 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	max_health = "%s" % [PlayerManager.health]
	health = max_health
	PlayerManager.on_health_decrease.connect(update_text)
	PlayerManager.on_health_increase.connect(update_text)
	text = health + "/" + max_health

func update_text(value):
	await get_tree().process_frame
	health = "%s" % [value]
	text = health + "/" + max_health
