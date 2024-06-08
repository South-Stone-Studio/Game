class_name Run

extends Node3D

@export var dun_generator: DungeonGeneration
@export var room_generator: RoomGenerator
@export var player: Node3D
@export var portals: Array[Portal]
var current_room: Gnode
func _ready():
	var c: int = 0
	for p in portals:
		p.num = c
		c+=1
	dun_generator.create_dungeon()
	current_room = dun_generator.get_rooms()
	room_generator.create_room(current_room.room_type)
	var _room: Room = room_generator.get_ref()
	_room.spawn_player(player)
	for p in portals:
		p.changeRoom.connect(changeRoom)
	swap_portals(len(current_room.connections))

func changeRoom(num):
	if len(current_room.connections) > num:
		room_generator.delete_room()
		current_room = current_room.connections[num]
		swap_portals(len(current_room.connections))
		room_generator.create_room(current_room.room_type)
	
func swap_portals(num):
	for p in portals:
		p.activate()
	for i in range(num, 4):
		portals[i].disablem()
