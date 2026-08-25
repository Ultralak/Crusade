extends TileMapLayer
@onready var exit: Node2D = $"../exit"

var first_side : Vector2 
var second_side : Vector2
const TILESIZE = 16
const ATLAS_ID = 1

@export var side_wall : Vector2i
@export var bottom_wall : Vector2i
@export var bottom_wall_left_open : Vector2i
@export var bottom_wall_right_open : Vector2i
var delete : Vector2i = Vector2i(-1,-1)

func _ready() -> void:
	decide_doors()

func decide_doors():
	for i in exit.get_children():
		if i is DoorMarker:
			if i.direction == DoorMarker.Direction.Up or i.direction == DoorMarker.Direction.Down :
				first_side = i.global_position + Vector2.LEFT * TILESIZE
				second_side = i.global_position + Vector2.RIGHT * TILESIZE/2
				if !i.activated:
					show_wall_V(first_side,second_side)
				else:
					show_open_door_V(first_side,second_side)
			elif i.direction == DoorMarker.Direction.Right or i.Direction.Left == DoorMarker.Direction.Left:
				first_side = i.global_position + Vector2.UP * TILESIZE/2
				second_side = i.global_position + Vector2.DOWN * TILESIZE/2
				if !i.activated:
					show_wall_H(first_side,second_side)
				else:
					show_open_door_H(first_side,second_side)

## Show open door for up and down markers. I have tiles for this
func show_open_door_V(L : Vector2, R : Vector2):
	change_tile_at_position(self,L,bottom_wall_left_open)
	change_tile_at_position(self,R,bottom_wall_right_open)
## remove tiles at left and right markers . I don't have a gate in my tileset for left and right so this the best i can do
func show_open_door_H(L : Vector2, R : Vector2):
	change_tile_at_position(self,L,delete)
	change_tile_at_position(self,R,delete)

func change_tile_at_position(layer : TileMapLayer, tile_position : Vector2, atlasTextureCoords : Vector2i) -> void:
	var local_pos = layer.to_local(tile_position)
	var coordinates = layer.local_to_map(local_pos)
	layer.set_cell(coordinates ,ATLAS_ID,atlasTextureCoords)
	
## show wall for top and bottom sides. I have tiles for that so i show it
func show_wall_V(L : Vector2, R : Vector2):
	change_tile_at_position(self,L,bottom_wall)
	change_tile_at_position(self,R,bottom_wall)

## show wall for left and right sides . 
## Basically just showing normal wall
func show_wall_H(L : Vector2, R : Vector2):
	change_tile_at_position(self,L,side_wall)
	change_tile_at_position(self,R,side_wall)
