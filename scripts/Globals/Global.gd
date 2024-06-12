extends  Node

var player: PlayerMovement
var run_script: Run

var normal_tiles: Array[PackedScene]
var portal_tiles: Array[PackedScene]
var spawn_tiles: Array[PackedScene]

var path_to_normal: String = "res://component scene/procedural generation/tiles/normal tiles/"
var path_to_portal: String = "res://component scene/procedural generation/tiles/portal tiles/"
var path_to_spawn: String = "res://component scene/procedural generation/tiles/spawn tiles/"

func _ready() -> void:
	normal_tiles = load_tiles(path_to_normal)
	portal_tiles = load_tiles(path_to_portal)
	spawn_tiles = load_tiles(path_to_spawn)
	print(len(normal_tiles))
	print(len(portal_tiles))
	print(len(spawn_tiles))
	
func load_tiles(s: String) -> Array[PackedScene]:
	var tab: Array[PackedScene] = []
	var dir := DirAccess.open(s)
	if dir:
		for file_name in dir.get_files():
			print(s+file_name)
			tab.append(load(s+file_name))
	return tab
