class_name Dungeon_genera

extends Node

enum room_types {start, normal, treasure, trap, boss}

class Gnode:
	var index: int
	var connections:Array[Gnode]
	var room_type: room_types
	
	func _init(_index: int,_room_type:room_types):
		index = _index
		room_type = _room_type
		connections = []

var graph: Gnode
@export var max_connections: int = 4
@export var min_main_length: int = 6
@export var max_main_length: int = 10
@export var min_room_count: int = 17
@export var max_room_count: int = 22

@export var max_depth: int = 10
var _cur_index: int = 9 
var rooms = []

var generator: RandomNumberGenerator = RandomNumberGenerator.new()

func create_connection(origin: Gnode, destination: Gnode):
	origin.connections.append(destination)
	destination.connections.append(origin)

func create_graph():
	var _main_path_length: int = generator.randi_range(min_main_length, max_main_length)
	var _origin: Gnode = Gnode.new(0, room_types.start)
	graph = _origin
	var _last_room: Gnode = create_main_path(_origin, _main_path_length)
	_origin = _last_room.connections[0]
	while true:
		if generator.randi_range(0, 100) % 2 == 0:
			var _depth = randi_range(1, max_depth)
			create_sub_path(_depth, _origin)
		if _origin.index == 0:
			break
		_origin = _origin.connections[0]

func create_main_path(_origin: Gnode, _length: int) -> Gnode:
	for i in range(_length):
		var _current: Gnode = Gnode.new(i+1, room_types.normal)
		create_connection(_origin, _current)
		_origin = _current
	var _boss_room: Gnode = Gnode.new(8 , room_types.boss)
	create_connection(_origin, _boss_room)
	return _origin
	
func create_sub_path(_depth: int, _origin: Gnode):
	if _depth <= 0:
		return
	var _count: int = generator.randi_range(0, max_connections-len(_origin.connections))
	for i in range(_count):
		var _new = Gnode.new(_cur_index, room_types.normal)
		create_connection(_origin, _new)
		_cur_index += 1
		_depth = generator.randi_range(_depth/2, _depth)
		create_sub_path(_depth - 1, _new)

func debug_graph(node: Gnode, indexes:Array[int]) -> Array[int]:
	indexes.append(node.index)
	for n in node.connections:
		if n.index not in indexes:
			debug_graph(n,indexes)
	return indexes

func _ready():
	while true:
		create_graph()
		var _a: int = len(debug_graph(graph, []))
		print(_a)
		if max_room_count >= _a and _a >=  min_room_count:
			break
