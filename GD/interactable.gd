extends CollisionShape2D
class_name Interactable

@onready var interact_region: Interactable = $"."
@onready var interact_icon: Node2D = $WeaponHover

func interact():
	pass

# these will be turned of by the item itself
func disable_interact_area()->void:
	interact_region.monitorable = false
	interact_region.monitoring = false

func enable_interact_area()->void:
	interact_region.monitorable = true
	interact_region.monitoring = true

func interaction_enable()->void:
		interact_icon.show()
	
func interaction_disable()->void:
		interact_icon.visible = false
