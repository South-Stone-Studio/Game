class_name DungeonGeneration

extends Node

var graph: Gnode

@export_category("Graph")
@export var max_connections: int = 4
@export var min_main_length: int = 6
@export var max_main_length: int = 10
@export var min_room_count: int = 17
@export var max_room_count: int = 22
@export var max_depth: int = 10

@export_category("Room")
@export_range(1,100) var max_width: int
@export_range(1, 100) var min_width: int
@export_range(1, 100) var max_height: int
@export_range(1, 100) var min_height: int
@export var spawn_room_tiles: Array[PackedScene]


@export_category("Debug")
@export var boss: PackedScene
@export var only_boss_room: bool = false
var node_count: int = 0
var _cur_index: int = max_main_length + 1
var rooms = []


func create_connection(origin: Gnode, destination: Gnode):
	origin.connections.append(destination)
	destination.connections.append(origin)

func create_graph():
	var _main_path_length: int = randi_range(min_main_length, max_main_length)
	var _origin: Gnode = Gnode.new(0, room.room_types.start)
	var _graph: Gnode = _origin
	if only_boss_room:
		var _boss_room: Gnode = Gnode.new(1 , room.room_types.boss)
		create_connection(_origin, _boss_room)
		return _graph
	var _last_room: Gnode = create_main_path(_origin, _main_path_length)
	_origin = _last_room.connections[0]
	while true:
		if randi_range(0, 100) % 2 == 0:
			var _depth = randi_range(1, max_depth)
			create_sub_path(_depth, _origin)
		if _origin.index == 0:
			break
		_origin = _origin.connections[0]
	return _graph

func create_main_path(_origin: Gnode, _length: int) -> Gnode:
	for i in range(_length):
		var _current: Gnode = Gnode.new(i+1, room.room_types.normal)
		create_connection(_origin, _current)
		_origin = _current
	var _boss_room: Gnode = Gnode.new(8 , room.room_types.boss)
	create_connection(_origin, _boss_room)
	return _origin
	
func create_sub_path(_depth: int, _origin: Gnode):
	if _depth <= 0:
		return
	var _count: int = randi_range(0, max_connections-len(_origin.connections))
	for i in range(_count):
		var _new = Gnode.new(_cur_index, room.room_types.normal)
		create_connection(_origin, _new)
		_cur_index += 1
		@warning_ignore("integer_division")
		_depth = randi_range(_depth/2, _depth)
		create_sub_path(_depth - 1, _new)

func map_graph(node: Gnode, indexes:Array[int] , f: Callable) -> void:
	indexes.append(node.index)
	if f:
		f.call(node)
	for n in node.connections:
		if n.index not in indexes:
			map_graph(n, indexes, f)

func count_nodes(_node: Gnode):
	node_count += 1
	
func create_room(node: Gnode):
	var req_tiles:Array[PackedScene] = []
	match node.room_type:
		room.room_types.start:
			req_tiles.append_array(spawn_room_tiles)
		room.room_types.boss:
			req_tiles.append_array(Global.current_boss.boss_tiles)
	node.create_room(
		len(node.connections), 
		Vector2i(min_height,max_height), 
		Vector2i(min_width,max_width), 
		req_tiles
	)

func free_graph(node: Gnode, indexes:Array[int]=[]):
	indexes.append(node.index)
	for n in node.connections:
		if n.index not in indexes:
			free_graph(n,indexes)
	node.free()

func create_dungeon():
	choose_boss()
	if graph != null:
		free_graph(graph)
	while true:
		node_count = 0
		graph = create_graph()
		map_graph(graph, [], count_nodes)
		if (max_room_count >= node_count and node_count >=  min_room_count) or only_boss_room:
			break
	map_graph(graph, [], create_room)
	
func get_graph():
	return graph

func choose_boss():
	if boss == null:
		var m := randi() % len(Global.first_bosses)
		Global.current_boss = Global.first_bosses[m].instantiate()
	else:
		Global.current_boss = boss.instantiate()
