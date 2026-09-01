extends Label

@export var increase_outline_color: Color = Color.GREEN
@export var decrease_outline_color: Color = Color.RED
@export var default_outline_color: Color = Color.BLACK

var displayed_coins: int = 0

func _ready() -> void:
	# Duplicate LabelSettings to prevent modifying other labels sharing this resource
	if label_settings:
		label_settings = label_settings.duplicate()
		if label_settings.outline_size == 0:
			label_settings.outline_size = 4
			
	# Keep the pivot in the center of the label for clean scale pop
	pivot_offset = size / 2.0
	resized.connect(func(): pivot_offset = size / 2.0)
	
	# Fetch starting coins from PlayerManager
	displayed_coins = PlayerManager.coins
	text = str(displayed_coins)
	
	# Listen for global coin changes
	PlayerManager.coins_updated.connect(_on_coins_updated)

func _on_coins_updated(new_amount: int) -> void:
	if new_amount == displayed_coins:
		return

	# Determine outline color based on balance shift direction
	var flash_color: Color = increase_outline_color if new_amount > displayed_coins else decrease_outline_color
	
	# Create a parallel tween for animations
	var tween = create_tween().set_parallel(true)
	
	# 1. Juice: Quick scale pop up, then return to normal scale
	var scale_tween = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	scale_tween.tween_property(self, "scale", Vector2(1.3, 1.3), 0.1)
	scale_tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.15)
	
	# 2. Outline Color: Instantly flash red/green, then smoothly return to default
	if label_settings:
		label_settings.outline_color = flash_color
		tween.tween_property(label_settings, "outline_color", default_outline_color, 0.5)\
			.set_delay(0.2)
	
	# 3. Number Roll-up: Smoothly step from old balance to new balance
	tween.tween_method(_update_coin_text, displayed_coins, new_amount, 0.35)
	
	displayed_coins = new_amount

func _update_coin_text(value: int) -> void:
	text = str(value)
