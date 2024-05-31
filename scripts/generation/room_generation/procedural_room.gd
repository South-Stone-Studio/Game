class_name ProceduralRoom

extends Room

var width: int = 0
var height: int = 0
@export var area_of_room = 1200
@export var max_length: int = 48
@export var wall: PackedScene

func _ready():
	calculate_walls(max_length, area_of_room)
	create_walls()

func calculate_walls(max_x: int, area: int):
	var min_x: int = area/ max_x 
	var x: int = randi_range(min_x, max_x)
	width = x
	height = area/x
	print(width, " ", height)
	
func create_wall(x:int,z:int, _wall: Node3D,rotation: float = 0):
		var _w: Node3D = _wall.duplicate()
		_w.rotate_y(deg_to_rad(rotation))
		$".".add_child(_w)
		var pos: Vector3 = _w.position
		_w.position = Vector3(1*x, pos.y, 1*z)

func create_walls():
	var _wall: Node3D = wall.instantiate()
	for x in range(0, width):
		create_wall(x, 0, _wall)
		create_wall(width-x, height, _wall, 180)
	for y in range(0, height):
		create_wall(width, y, _wall, -90)
		create_wall(0, height-y, _wall, 90)
	
