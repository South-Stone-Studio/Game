class_name ProceduralRoom

extends Node3D


var width: int = 0
var height: int = 0

func _init(h: Vector2i, w: Vector2i, t: Array[PackedScene]) -> void:
	Global.run_script.add_child(self)
	width = randi_range(w.x, w.y)
	height = randi_range(h.x, h.y)
	var tiles: Array[PackedScene] = []
	var tile_count = (width * height) - 1 - 1
	var m := len(Global.portal_tiles) - 1
	

	tiles.append(Global.portal_tiles[randi_range(0, m)])
	m = len(Global.spawn_tiles) - 1
	tiles.append(Global.spawn_tiles[randi_range(0, m)])
	m = len(Global.normal_tiles) - 1
	for i in range(tile_count- len(t)):
		tiles.append(Global.normal_tiles[randi_range(0, m)])
	for i in t:
		tiles.append(i)
	tiles.shuffle()
	
	for y in range(height):
		for x in range(width):
			var tile: Tile = tiles.pop_back().instantiate()
			self.add_child(tile)
			tile.create(x * 10, y * 10)
	create_walls()
	Global.run_script.remove_child(self)

func create_wall(x: int,z: int, _wall: Node3D,rot: float = 0):
		var _w: Node3D = _wall.duplicate()
		_w.rotate_y(deg_to_rad(rot))
		self.add_child(_w)
		var pos: Vector3 = _w.position
		_w.position = Vector3(x*10-5, pos.y, z*10-5)

func create_walls():
	var _wall: Node3D = Global.wall.instantiate()
	for x in range(0, width):
		create_wall(x, 0, _wall)
		create_wall(width-x, height, _wall, 180)
	for y in range(0, height):
		create_wall(width, y, _wall, -90)
		create_wall(0, height-y, _wall, 90)
