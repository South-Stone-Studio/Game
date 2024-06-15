class_name SpawnTile

extends Tile

@export var spawn_point: Node3D

func _ready() -> void:
	Global.player.global_position = spawn_point.global_position
	request_ready()
