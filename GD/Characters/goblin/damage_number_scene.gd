extends Label

# TODO in future add handling of more complex details for different modes
func setup_damage_labels(value : int, color : String)->void:
	text = str(value)
	z_index = 10
	label_settings.font_color = color
	
