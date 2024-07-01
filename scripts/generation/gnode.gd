class_name Gnode

var index: int
var connections:Array[Gnode]
var room_type: room.room_types
var added_to_map: bool = false
var root_node: ProceduralRoom

func _init(_index: int,_room_type:room.room_types) -> void:
	index = _index
	room_type = _room_type
	connections = []

func create_room(height: Vector2i, width: Vector2i, tiles: Array[PackedScene]) -> void:
	root_node = ProceduralRoom.new(height, width, tiles)
