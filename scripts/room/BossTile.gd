class_name BossTile

extends Tile

@export var boss_spawn: Node3D

func _ready() -> void:
	var boss: Boss = Global.current_boss
	print(boss, boss_spawn)
	get_parent().add_child(boss)
	boss.global_position = boss_spawn.position
