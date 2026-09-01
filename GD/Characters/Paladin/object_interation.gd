extends Area2D
class_name ObjectInteraction

var interactable_objects : Array[Interactable]
var active_interactable : Interactable
@export var Inventory : InventorySystem
@export var player : Character
var delta_timer : float = 0
func _ready() -> void:
	pass
	
func _process(_delta: float) -> void:
	update_closest_interactabe_object()
	
		
	
func update_closest_interactabe_object()->void:
	var min_distance : float = INF
	active_interactable = null
	
	for child in interactable_objects:
		child.interaction_disable()
		var distance_to_player : float = child.global_position.distance_to(player.global_position)
		if distance_to_player <= min_distance:
			min_distance = distance_to_player
			active_interactable = child
			
	if active_interactable: 
		active_interactable.interaction_enable()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and active_interactable:
		active_interactable.interact()
		if active_interactable:
			print("Interacted with %s in the world!" % [active_interactable.name])
			get_viewport().set_input_as_handled()

	
func _on_area_exited(area : Area2D) -> void:
	if area is Interactable and interactable_objects.has(area):
		area.interaction_disable()
		interactable_objects.erase(area)
		update_closest_interactabe_object()
	
func _on_area_entered(area : Area2D) -> void:
	if area is Interactable and !interactable_objects.has(area):
		interactable_objects.append(area)
		update_closest_interactabe_object()


		
