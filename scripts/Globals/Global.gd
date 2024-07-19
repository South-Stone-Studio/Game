extends  Node

var inventory : Array[Item]

var player: PlayerMovement
var run_script: Run
var map: Map
var current_room_root: Node3D
var current_room_gnode: Gnode
var current_boss: Boss

var normal_tiles: Array[PackedScene]
var portal_tiles: Array[PackedScene]
var spawn_tiles: Array[PackedScene]

var small_placable: Array[PackedScene]
var medium_placable: Array[PackedScene]
var large_placable: Array[PackedScene]

var base_weapons: Array[PackedScene]
var first_bosses: Array[PackedScene]

var path_to_first_bosses: String = "res://component scene/boss/first_floor/"
var path_to_normal: String = "res://component scene/procedural generation/tiles/normal tiles/"
var path_to_portal: String = "res://component scene/procedural generation/tiles/portal tiles/"
var path_to_spawn: String = "res://component scene/procedural generation/tiles/spawn tiles/"
var path_to_small_objects: String = "res://component scene/props/placable/small/"
var path_to_medium_objects: String = "res://component scene/props/placable/medium/"
var path_to_large_objects: String = "res://component scene/props/placable/large/"
var path_to_base_weapons: String = "res://component scene/weapons/base/"
var wall: PackedScene = preload("res://component scene/props/wall/wall.tscn")

func _ready() -> void:
	normal_tiles = load_assets(path_to_normal)
	portal_tiles = load_assets(path_to_portal)
	spawn_tiles = load_assets(path_to_spawn)
	small_placable = load_assets(path_to_small_objects)
	medium_placable = load_assets(path_to_medium_objects)
	large_placable = load_assets(path_to_large_objects)
	base_weapons = load_assets(path_to_base_weapons)
	first_bosses = load_assets(path_to_first_bosses)
	
func load_assets(s: String) -> Array[PackedScene]:
	var tab: Array[PackedScene] = []
	var dir := DirAccess.open(s)
	if dir:
		for file_name in dir.get_files():
			print(s+file_name)
			tab.append(load(s+file_name))
	return tab





