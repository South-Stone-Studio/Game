class_name ProceduralRoom

extends Room


var width: int = 0
var height: int = 0

var grid: Array[Array]

func _init(portal_count: int, h: Vector2i, w: Vector2i) -> void:
	Global.run_script.add_child(self)
	width = randi_range(w.x, w.y)
	height = randi_range(h.x, h.y)
	var tiles: Array[PackedScene] = []
	var tile_count = (width * height) - portal_count - 1
	var portal_num := []
	var m := len(Global.portal_tiles) - 1
	for i in range(portal_count):
		portal_num.append(i)
		tiles.append(Global.portal_tiles[randi_range(0, m)].duplicate())
	m = len(Global.spawn_tiles) - 1
	tiles.append(Global.spawn_tiles[randi_range(0, m)].duplicate())
	m = len(Global.normal_tiles) - 1
	for i in range(tile_count):
		tiles.append(Global.normal_tiles[randi_range(0, m)].duplicate())
	tiles.shuffle()
	portal_num.shuffle()
	for y in range(height):
		for x in range(width):
			print(x,y)
			var tile: Tile = tiles.pop_back().instantiate()
			if is_instance_of(tile, PortalTile):
				tile.set_portal(portal_num.pop_back())
			self.add_child(tile)
			tile.create(x * 10, y * 10)
	Global.run_script.remove_child(self)
