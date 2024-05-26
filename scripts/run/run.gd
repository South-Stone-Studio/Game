extends Node3D


@export var generator: DungeonGeneration
@export var spawn: Room_Generator
@export var player: Node3D
var current_room: Gnode
func _ready():
	generator.create_dungeon()
	current_room = generator.get_rooms()
	spawn.create_room(current_room.room_type)
	var _room:Room = spawn.get_ref()
	print(player)
	_room.spawn_player(player)
	
