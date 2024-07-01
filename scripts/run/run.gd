class_name Run

extends Node3D

@export var dun_generator: DungeonGeneration
@export var player: Node3D

var current_room: Gnode
var r: Node3D

func _ready() -> void:
	if Global.run_script == null:
		Global.run_script = self
	dun_generator.create_dungeon()
	current_room = dun_generator.get_graph()
	r = current_room.r
	Global.current_room_root = r
	Global.current_room_gnode = current_room
	Global.map.init_map(current_room)
	add_child(r)

func changeRoom(num) -> void:
	remove_child(r)
	if len(current_room.connections) > num:
		current_room = current_room.connections[num]
		r = current_room.r
		Global.current_room_root = r
		Global.current_room_gnode = current_room
	add_child(r)
