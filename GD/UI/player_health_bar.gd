extends ProgressBar
class_name CustomProgressBar
@export var DamageBar : ProgressBar

var change_value_tween : Tween
var opacity_tween : Tween
var damage_time : float

func _ready():
	PlayerManager.register_healthbar(self)
	PlayerManager.on_health_decrease.connect(decrease_value)
	PlayerManager.on_health_increase.connect(increase_value)

func setup_health_bar(health  :float):
	
	modulate.a = 1.0
	value = health
	
	max_value = value
	DamageBar.value = value
	DamageBar.max_value = value

func decrease_value(new_value :float):
	change_opacity(1.0)
	#await opacity_tween.finished
	
	value = new_value
	
	if change_value_tween:
		change_value_tween.kill()
	change_value_tween = create_tween()
	change_value_tween.tween_property(DamageBar, "value", new_value , damage_time).set_trans(Tween.TRANS_SINE)
	
func increase_value(new_value  :float):
	change_opacity(1.0)
	value = new_value
	if DamageBar.value <= new_value:
		DamageBar.value = new_value
		
		
func change_opacity(new_amount : float):
	if opacity_tween:
		opacity_tween.kill()
	opacity_tween = create_tween()
	opacity_tween.tween_property(self, "modulate:a", new_amount, 0.12).set_trans(Tween.TRANS_SINE)
	
