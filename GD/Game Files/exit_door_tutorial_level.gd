extends StaticBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var player_y_sort: Area2D = $player_y_sort
var player_y_sorted : bool  = false
var prev_z_index_player : int

func open()->void:
	animation_player.speed_scale = 1.5
	animation_player.play("open")
	
func close() -> void:
	animation_player.speed_scale = 0.8
	animation_player.play("close")



func _on_player_y_sort_area_entered(area: Area2D) -> void:
	var entity : CharacterBody2D = area.get_parent()
	if entity.is_in_group("PLAYER"):
		player_y_sorted = true
		prev_z_index_player = entity.z_index
		entity.z_index = z_index - 2


func _on_player_y_sort_area_exited(area: Area2D) -> void:
	var entity : CharacterBody2D = area.get_parent()
	if entity.is_in_group("PLAYER") and player_y_sorted:
		player_y_sorted = false
		entity.z_index = prev_z_index_player
