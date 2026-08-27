extends Area2D
class_name Interactable

@onready var interact_region: Interactable = $"."
@onready var interact_icon: Node2D = $WeaponHover

func interact():
	pass

## This function disables monitoring and monitoring for the area2d
func disable_interact_area()->void:
	interact_region.monitorable = false
	interact_region.monitoring = false
## This function enables monitoring and monitoring for the area2d
func enable_interact_area()->void:
	interact_region.monitorable = true
	interact_region.monitoring = true

## This shows interact icon scene
func interaction_enable()->void:
		interact_icon.show()
		
## This hides interact icon scene
func interaction_disable()->void:
		interact_icon.visible = false
