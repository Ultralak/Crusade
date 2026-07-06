extends Node

@export var characterbody_2d : CharacterBody2D
var enemy_death_effect = preload("res://Enemies/melee/enemy_death.tscn")
@export var healthbar : ProgressBar
signal enemy_hit





func damage_taken(amount : float):
	characterbody_2d.health -= amount
	EnemyHealthManager.update_dictionary(characterbody_2d.name , characterbody_2d.health)
	if characterbody_2d.health <= 0:
		enemy_dead()
	enemy_hit.emit()
	if healthbar:
		healthbar.health = characterbody_2d.health

func enemy_dead():
	var enemy_death_effect_instance = enemy_death_effect.instantiate() as Node2D
	enemy_death_effect_instance.global_position = characterbody_2d.global_position
	get_parent().get_parent().add_child(enemy_death_effect_instance)
	characterbody_2d.queue_free()
	
func init_health():
	return characterbody_2d.health
