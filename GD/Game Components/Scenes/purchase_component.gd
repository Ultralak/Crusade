class_name PurchaseComponent
extends Node2D

signal purchase_succeeded
signal purchase_failed
signal purchase_done

@export var price: int = 10
@export var interactable: Interactable
@export var price_label: Label
@export var item_pickup_component: ItemPickupComponent


func _ready() -> void:
	if price_label:
		price_label.text = str(price)

	if interactable:
		interactable.interacted.connect(_on_interacted)


func _on_interacted() -> void:
	if PlayerManager.spend_coins(price):
		purchase_succeeded.emit()
	else:
		purchase_failed.emit()
		_play_deny_feedback()

func delete()->void:
	purchase_done.emit()
	if !price_label.is_queued_for_deletion():
		price_label.queue_free()
	queue_free()


func _play_deny_feedback() -> void:
	if price_label:
		var original_color = price_label.modulate
		price_label.modulate = Color.RED
		var tree = get_tree()
		if tree:
			await tree.create_timer(0.2).timeout
			if is_instance_valid(price_label):
				price_label.modulate = original_color
