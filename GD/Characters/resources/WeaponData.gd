extends Resource
class_name WeaponData

@export_group("Identity")
@export var name: String = "Default Weapon"
@export_multiline var description: String = ""
@export var weapon_sprite: Texture2D
@export var ground_sprite: Texture2D
@export_file("*.tscn") var weapon_scene_path: String

@export_group("Combat Stats")
@export var penetration: int = 1
@export_range(0, 100, 0.1, "hide_control", "or_greater", "suffix:Points") var damage_amount: float = 10.0
@export_range(0, 100) var critical_hit_chance: float = 5.0
@export_range(0, 10, 0.1, "or_greater") var critical_hit_damage_multiplier: float = 2.0
@export_range(0, 1000, 1, "hide_control", "or_greater") var knockback_force: float = 100.0

@export_group("Firing Logic")
@export var bullet_scene: PackedScene
@export_range(0.1, 100.0, 0.1, "or_greater", "suffix:bullets/s") var fire_rate: float = 5.0
@export_range(1, 1000, 1, "or_greater") var bullet_velocity: float = 400.0
@export_range(0, 180) var weapon_bloom: int = 0

@export_group("Pattern Stats")
@export_range(1, 20, 1, "or_greater") var pellets_per_shot: int = 1
@export_range(1, 10, 1, "or_greater") var burst_count: int = 1
@export_range(0.01, 1.0, 0.01, "suffix:s") var burst_delay: float = 0.08

@export_group("Energy")
@export var energy_cost: int = 30

@export_group("Recoil")
@export var recoil_distance: float = 6.0
@export var recoil_duration: float = 0.12
