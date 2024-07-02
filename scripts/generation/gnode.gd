class_name Gnode

var index: int
var connections:Array[Gnode]
var room_type: room.room_types
var r: ProceduralRoom

func _init(_index: int,_room_type:room.room_types) -> void:
	index = _index
	room_type = _room_type
	connections = []

func create_room(portal_count: int, height: Vector2i, width: Vector2i, tiles: Array[PackedScene]) -> void:
	r = ProceduralRoom.new(portal_count, height, width, tiles)
