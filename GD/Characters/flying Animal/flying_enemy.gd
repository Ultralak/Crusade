@icon("res://Art/enemies/flying creature/fly_anim_f3.png")
extends CharacterBody2D

@export var max_health : float  = 10.0
@export var damage_amount : float  = 4
@export var detection_radius : float = 50
@export var max_chase_distance : float = 1000
var knockback_dir : Vector2
@export var knockback_force : float
