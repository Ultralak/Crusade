class_name TreasureChest
extends Node2D

@export var loot_table: LootTable
@export var interactable: Interactable
@export var sprite: Sprite2D
@export var open_texture: Texture2D
@export var item_drop_count: int = 1
@export var drop_offset_distance: float = 28.0

var is_opened: bool = false


func _ready() -> void:
	if interactable:
		interactable.interacted.connect(_on_interacted)


func _on_interacted() -> void:
	if is_opened:
		return

	is_opened = true

	if interactable:
		interactable.monitoring = false
		interactable.monitorable = false
		interactable.visible = false

	play_open_juice()


func play_open_juice() -> void:
	if not sprite:
		spawn_loot()
		return

	var tween: Tween = create_tween()
	
	tween.tween_property(sprite, "scale", Vector2(1.25, 0.75), 0.1).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property(sprite, "scale", Vector2(0.85, 1.25), 0.08).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	if open_texture:
		tween.tween_callback(func(): sprite.texture = open_texture)
		
	tween.tween_property(sprite, "scale", Vector2.ONE, 0.12).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	
	await tween.finished
	spawn_loot()


func spawn_loot() -> void:
	if not loot_table or item_drop_count <= 0:
		return

	var chosen_items: Array[LootItem] = loot_table.pick_unique_loot_items(item_drop_count)
	if chosen_items.is_empty():
		return

	var spawn_origin: Vector2 = global_position
	var base_angle: float = randf() * TAU
	var angle_step: float = TAU / chosen_items.size()

	for i in range(chosen_items.size()):
		var chosen_loot: LootItem = chosen_items[i]
		if not chosen_loot or not chosen_loot.item_scene:
			continue

		var pickup_instance = chosen_loot.item_scene.instantiate()
		get_parent().add_child(pickup_instance)
		pickup_instance.global_position = spawn_origin

		var jitter: float = randf_range(-0.15, 0.15)
		var item_angle: float = base_angle + (i * angle_step) + jitter
		var landing_position: Vector2 = spawn_origin + (Vector2.RIGHT.rotated(item_angle) * drop_offset_distance)

		if chosen_loot.item_data:
			if pickup_instance.has_method("setup_item"):
				pickup_instance.setup_item(chosen_loot.item_data)
			elif "item_data" in pickup_instance:
				pickup_instance.item_data = chosen_loot.item_data
			elif "weapon_data" in pickup_instance:
				pickup_instance.weapon_data = chosen_loot.item_data
			if "purchase_component" in pickup_instance:
				pickup_instance.purchase_component.delete()

		animate_item_launch(pickup_instance, spawn_origin, landing_position)


func animate_item_launch(item_node: Node2D, start_pos: Vector2, target_position: Vector2, arc_height: float = 20.0) -> void:
	var visual_node: CanvasItem = item_node.get_node_or_null("Sprite2D")
	
	item_node.global_position = start_pos

	var floor_tween: Tween = create_tween()
	floor_tween.tween_property(item_node, "global_position", target_position, 0.4).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

	if not visual_node:
		return

	var original_y: float = visual_node.position.y

	var arc_tween: Tween = create_tween()
	arc_tween.tween_property(visual_node, "position:y", original_y - arc_height, 0.2).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	arc_tween.tween_property(visual_node, "position:y", original_y, 0.2).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)

	await arc_tween.finished

	var bounce_tween: Tween = create_tween()
	bounce_tween.tween_property(visual_node, "position:y", original_y - (arc_height * 0.3), 0.1).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	bounce_tween.tween_property(visual_node, "position:y", original_y, 0.1).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
