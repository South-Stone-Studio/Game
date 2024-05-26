class_name Gnode

var index: int
var connections:Array[Gnode]
@export var room_type: room.room_types

func _init(_index: int,_room_type:room.room_types):
	index = _index
	room_type = _room_type
	connections = []
