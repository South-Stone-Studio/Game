class_name EnemyMovement

extends Enemy

@export_category("vision")
@onready var player : CharacterBody3D
@export var vision : Area3D
@export var nav_agent : NavigationAgent3D

@export_category("patrol options")
var hunting : bool = false
enum patrol_mode {hold_position, prepared_patrol, random_patrol}
@export var mode_of_patrol : patrol_mode
@export var patrol_points : Array[Marker3D]

func _ready() -> void:
	super._ready()
	player = Global.player

func _process(delta : float) -> void:
	super._process(delta)
	if hunting:
		move_to_pos(player.position)

func move_to_pos(pos : Vector3) -> void:
	velocity = Vector3.ZERO
	nav_agent.set_target_position(pos)
	var next_nav_point : Vector3 = nav_agent.get_next_path_position()
	velocity = (next_nav_point - global_transform.origin).normalized() * speed
	move_and_slide()

func _on_vision_timer_timeout() -> void:
	hunting = false
	var overlaps = vision.get_overlapping_bodies()
	if overlaps.size() > 0:
		for overlap in overlaps:
			if overlap.name == "Player":
				self.look_at(Vector3(player.position.x, player.position.y, player.position.z), Vector3(0, 1, 0))
				hunting = true
