extends Node

var playercamera : Camera2D

func register(camera : Camera2D)->void:
	playercamera = camera

func add_trauma(amount : float)->void:
	playercamera.add_trauma(amount)
