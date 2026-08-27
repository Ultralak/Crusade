extends TileMapLayer
@onready var exit: Node2D = $"../exit"

var first_side : Vector2 
var second_side : Vector2
const TILESIZE = 16
const ATLAS_ID = 1
@onready var doors: Node2D = $"../Doors"

@export var side_wall : Vector2i
@export var bottom_wall : Vector2i
var delete : Vector2i = Vector2i(-1,-1)


func open()->void:
	open_doors()
	open_sides()

func close()->void:
	close_doors()
	close_sides()

func setup_room_walls() -> void:
	for i in exit.get_children():
		if i is DoorMarker:
			var is_horizontal : bool = (i.direction == DoorMarker.Direction.Right or i.direction == DoorMarker.Direction.Left)
			var is_vertical : bool = (i.direction == DoorMarker.Direction.Up or i.direction == DoorMarker.Direction.Down)
			if is_horizontal:
				first_side = i.global_position + Vector2.UP * TILESIZE / 2
				second_side = i.global_position + Vector2.DOWN * TILESIZE / 2
				
				if i.activated:
					show_open_door_H(first_side, second_side)
				else:
					show_wall_H(first_side, second_side)
			elif is_vertical:
				first_side = i.global_position + Vector2.LEFT * TILESIZE / 2
				second_side = i.global_position + Vector2.RIGHT * TILESIZE / 2

				if !i.activated:
					show_vertical_wall(first_side,second_side)
					delete_door(i)


func delete_door(k : DoorMarker)->void:
	var target_enum = Door.DOORPOSITION.up if k.direction == DoorMarker.Direction.Up else Door.DOORPOSITION.down
	
	for i in doors.get_children():
		if i is Door and i.door_position == target_enum:
			doors.remove_child(i)
			i.queue_free()


func open_sides() -> void:
	for i in exit.get_children():
		if i is DoorMarker:
			if i.direction == DoorMarker.Direction.Right or i.direction == DoorMarker.Direction.Left:
				if i.activated:
					first_side = i.global_position + Vector2.UP * TILESIZE / 2
					second_side = i.global_position + Vector2.DOWN * TILESIZE / 2
					show_open_door_H(first_side, second_side)


func close_sides() -> void:
	for i in exit.get_children():
		if i is DoorMarker:
			if i.direction == DoorMarker.Direction.Right or i.direction == DoorMarker.Direction.Left:
				if i.activated:
					first_side = i.global_position + Vector2.UP * TILESIZE / 2
					second_side = i.global_position + Vector2.DOWN * TILESIZE / 2
					show_wall_H(first_side, second_side)


func show_open_door_H(L : Vector2, R : Vector2):
	change_tile_at_position(self,L,delete)
	change_tile_at_position(self,R,delete)

func show_vertical_wall(L : Vector2, R : Vector2)->void:
	change_tile_at_position(self,L,bottom_wall)
	change_tile_at_position(self,L + Vector2.LEFT * TILESIZE,bottom_wall)
	change_tile_at_position(self,R,bottom_wall)
	change_tile_at_position(self,R + Vector2.RIGHT * TILESIZE,bottom_wall)

func change_tile_at_position(layer : TileMapLayer, tile_position : Vector2, atlasTextureCoords : Vector2i) -> void:
	var local_pos = layer.to_local(tile_position)
	var coordinates = layer.local_to_map(local_pos)
	layer.set_cell(coordinates,ATLAS_ID,atlasTextureCoords)

func show_wall_H(L : Vector2, R : Vector2):
	change_tile_at_position(self,L,side_wall)
	change_tile_at_position(self,R,side_wall)

func open_doors()->void:
	for i in doors.get_children():
		if i is Door:
			i.open()
			
func close_doors():
	for i in doors.get_children():
		if i is Door:
			i.close()
