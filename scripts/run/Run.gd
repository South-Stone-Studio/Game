class_name Run

extends Node3D

@export var dun_generator: DungeonGeneration
@export var player: Node3D

var current_room: Gnode

func _ready() -> void:
	if Global.run_script == null:
		Global.run_script = self
	dun_generator.create_dungeon()
	current_room = dun_generator.get_graph()
	change_room(current_room)
	Global.map.init_map(current_room)

func change_room(node: Gnode) -> void:
	if node != Global.current_room_gnode:
		if Global.current_room_root != null:
			remove_child(Global.current_room_root)
		Global.current_room_root = node.root_node
		Global.current_room_gnode = node
		add_child(Global.current_room_root)
