class_name Room

extends Node3D

@export var spawn: Node3D

func spawn_player(player:Node3D):
	player.set_position(spawn.position)
