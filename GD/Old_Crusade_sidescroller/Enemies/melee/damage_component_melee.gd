extends Node

@export var enemy : CharacterBody2D
var damage_amount : float

func _ready() -> void:
	damage_amount = enemy.damage
func _on_attack_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("PLAYER_"):
		if body.has_method("damage_taken"):
			body.damage_taken(damage_amount)
	
