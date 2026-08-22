extends Node

# used whenever a player picks up a weapon
signal player_picked_up_weapon(weapon : Weapon)

## Used to setup weapon every frame so it turns. Used to be a way yo alert weapon when player turned
signal player_turned
