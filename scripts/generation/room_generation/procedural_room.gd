class_name ProceduralRoom

extends Room

class element extends Object:
	var e: PackedScene
	var space: Vector2i
	func _init(_element: PackedScene, _space: Vector2i):
		space = _space
		e = _element

var width: int = 0
var height: int = 0
@export var area_of_room = 1200
@export var max_length: int = 48
@export var wall: PackedScene
@export var asset_types: Array[PackedScene]
@export var space_of_asset: Array[Vector2i]
var assets: Array[element]
var grid: Array[Array]

func _ready():
	for i in range(len(asset_types)):
		assets.append(element.new( asset_types[i], space_of_asset[i]))
	calculate_walls(max_length, area_of_room)
	create_walls()
	create_grid()
	calculate_obstacles()
	

func calculate_walls(max_x: int, area: int):
	var min_x: int = area/ max_x 
	var x: int = randi_range(min_x, max_x)
	width = x
	height = area/x
	print(width, " ", height)

func create_wall(x: int,z: int, _wall: Node3D,rot: float = 0):
		var _w: Node3D = _wall.duplicate()
		_w.rotate_y(deg_to_rad(rot))
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

func create_grid():
	for y in range(height):
		var _tab: Array[bool] = []
		for x in range(width):
			_tab.append(false)
		grid.append(_tab)

func calculate_obstacles():
	var obstacle_value: int = 200
	for i in assets:
		var val: int = i.space.x * i.space.y
		var num: int = randi_range(0, obstacle_value/2/val)
		obstacle_value -= num
		place_objects(i.e, num, i.space)
	grid.clear()

func place_objects(e:PackedScene, n:int, clear_area: Vector2i = Vector2i(1,1)):
	var obj: Node3D = e.instantiate()
	for i in range(n):
		var start: Vector2i = Vector2i(randi_range(2, width - 3),randi_range(2, height - 3))
		while not is_empty(start, clear_area):
			start = Vector2i(randi_range(1, width - 1),randi_range(1, height - 1))
		var ref: Node3D = obj.duplicate()
		$".".add_child(ref)
		ref.position = Vector3(start.x+.5, .5,start.y+.5)

func is_empty(start_pos: Vector2i, params: Vector2i):
	for i in range(start_pos.x, start_pos.x+params.x):
		for j in range(start_pos.y, start_pos.y+params.y):
			print(start_pos.x+i," ", start_pos.y+j)
			if grid[j][i]:
				return false
	for i in range(start_pos.x, start_pos.x+params.x):
		for j in range(start_pos.y, start_pos.y+params.y):
			grid[j][i] = true
	return true
