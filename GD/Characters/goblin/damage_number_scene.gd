extends Label

# TODO in future add handling of more complex details for different modes
func setup_damage_labels(value : int, color : Color, outline : Color)->void:
	text = str(value)
	z_index = 10
	label_settings.font_color = color
	label_settings.outline_color = outline
	
