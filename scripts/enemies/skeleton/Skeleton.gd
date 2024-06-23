class_name EnemyMovement

extends Enemy

@export_category("vision")
@onready var player : CharacterBody3D
@export var vision : Area3D
@export var nav_agent : NavigationAgent3D
@export var vision_raycast : RayCast3D
var saved_player_position : Vector3

@export_category("patrol options")
enum patrol {none, hold_position, random_patrol, prepared_patrol}
@export var patrol_mode : patrol
@export var patrol_points : Array[Marker3D]
@export var hold_position_points : Array[Vector3]
var hunt : bool = false
var alarmed : bool = false
@export var alarm_time : float

func _ready() -> void:
	super._ready()
	saved_player_position = self.position
	player = Global.player

func _process(delta : float) -> void:
	super._process(delta)
	# hunting and alarm
	if hunt:
		move_to_pos(player.position)
	elif !hunt and alarmed:
		if position.distance_to(saved_player_position) >= 1:
			move_to_pos(saved_player_position)
		else:
			alarmed = false
	else:
		do_patrol()

func move_to_pos(pos : Vector3) -> void:
	velocity = Vector3.ZERO
	nav_agent.set_target_position(pos)
	var next_nav_point : Vector3 = nav_agent.get_next_path_position()
	velocity = (next_nav_point - global_transform.origin).normalized() * speed
	move_and_slide()

func _on_vision_timer_timeout() -> void:
	var overlaps = vision.get_overlapping_bodies()
	if overlaps.size() > 0:
		hunt = false
		for overlap in overlaps:
			if overlap.name == "Player":
				alarmed = true
				vision_raycast.force_raycast_update()
				self.look_at(Vector3(player.position.x, 0.5, player.position.z), Vector3(0, 1, 0))
				if vision_raycast.is_colliding():
					var collider : Object = vision_raycast.get_collider()
					if collider.name == "Player":
						saved_player_position = player.position
						hunt = true

func do_patrol() -> void:
	if patrol_mode == patrol.hold_position:
		hold_position_points.shuffle()
		for point in hold_position_points:
			move_to_pos(position + point)
