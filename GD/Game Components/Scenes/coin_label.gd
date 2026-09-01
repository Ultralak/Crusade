extends Label

var displayed_coins: int = 0

func _ready() -> void:
	# Keep the pivot in the center of the label for clean scale pop
	pivot_offset = size / 2.0
	resized.connect(func(): pivot_offset = size / 2.0)
	
	# Fetch starting coins from PlayerManager
	displayed_coins = PlayerManager.coins
	text = str(displayed_coins)
	
	# Listen for global coin changes
	PlayerManager.coins_updated.connect(_on_coins_updated)

func _on_coins_updated(new_amount: int) -> void:
	# Create a parallel tween for scale and number roll-up
	var tween = create_tween().set_parallel(true)
	
	# 1. Juice: Quick scale pop up, then return to normal scale
	var scale_tween = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	scale_tween.tween_property(self, "scale", Vector2(1.3, 1.3), 0.1)
	scale_tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.15)
	
	# 2. Number Roll-up: Smoothly step from old balance to new balance
	tween.tween_method(_update_coin_text, displayed_coins, new_amount, 0.35)
	
	displayed_coins = new_amount

func _update_coin_text(value: int) -> void:
	text = str(value)
