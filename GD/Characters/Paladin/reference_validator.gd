extends Node

@export var target_node_parent: Node


func _ready() -> void:
	if !target_node_parent:
		target_node_parent = get_parent()
	if target_node_parent:
		validate(target_node_parent)
		
		
func validate(node : Node):
	
	var nodes = node.get_children(true)
	nodes.append(target_node_parent)
	
	for target_node in nodes:
		var script = target_node.get_script()
		if !script:
			continue
		var missing_count = 0
		
		for prop in target_node.get_property_list():
			var is_script_var = prop.usage & PROPERTY_USAGE_SCRIPT_VARIABLE
			var is_exported = prop.usage & PROPERTY_USAGE_EDITOR
			if is_script_var and is_exported:
				var prop_name = prop.name
				var value = target_node.get(prop_name)
				if is_value_null_or_empty(value):
					missing_count += 1
					
					print_rich("[color=yellow][i]⚠️ [VALIDATION ERROR] '%s'[/i][/color]in [color=aqua][i]'%s'[/i][/color][color=yellow][i] has an unassigned export: '%s' [/i][/color]" % [target_node.name,node.name, prop_name])
					
		if missing_count > 0:
			print_rich("[color=red][b]Validation failed for '%s' in '%s': %d missing reference(s) found.[/b][/color]" % [target_node.name,node.name, missing_count])
		else:
			pass
			#print_rich("[color=green]✔ Validation passed for '%s' [/color]in [color=aqua]'%s'.[/color]" % [target_node.name, node.name])
			
		
func is_value_null_or_empty(value) -> bool:
	
	if value == null:
		return true
	if value is Array or value is Dictionary or value is NodePath:
		if value.is_empty():
			return true
	if value is String:
		if value.strip_edges() == "": 
			return true
	return false
