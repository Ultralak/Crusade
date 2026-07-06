extends Node

var enemy_dictionary : Dictionary  =  {}

func update_dictionary(enemy_name : String, max_health : float) -> void:
	enemy_dictionary[enemy_name] = max_health

func get_health_data(enemy_name : String) -> float:
	return enemy_dictionary[enemy_name]
