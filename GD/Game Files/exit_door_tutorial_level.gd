extends StaticBody2D
class_name Door


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var player_y_sort: Area2D = $player_y_sort
var player_y_sorted : bool  = false
var prev_z_door : int
var speed_scale_open : float = randf_range(1,1.7)
var speed_scale_close : float = randf_range(0.6,0.8)
func open()->void:
	
	animation_player.speed_scale = speed_scale_open
	animation_player.play("open")
	
func close() -> void:
	animation_player.speed_scale = speed_scale_close
	animation_player.play("close")



func _on_player_y_sort_area_entered(area: Area2D) -> void:
	var entity : CharacterBody2D = area.get_parent()
	if entity.is_in_group("PLAYER"):
		player_y_sorted = true
		prev_z_door = z_index
		z_index = z_index + 2


func _on_player_y_sort_area_exited(area: Area2D) -> void:
	var entity : CharacterBody2D = area.get_parent()
	if entity.is_in_group("PLAYER") and player_y_sorted:
		player_y_sorted = false
		z_index = prev_z_door
