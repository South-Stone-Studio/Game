class_name EnemyMovement

extends Enemy

enum s_types {mele, range}
@export var sceleton_type : s_types

@export_category("vision")
@onready var player : CharacterBody3D
@export var vision : Area3D
@export var nav_agent : NavigationAgent3D
@export var vision_raycast : RayCast3D
var saved_player_position : Vector3

@export_category("patrol")
enum patrol {hold_position, prepared_patrol}
@export var patrol_mode : patrol
@export var patrol_points : Array[Marker3D]
var hunt : bool = false
var alarmed : bool = false

@export_category("hold_position")
@export var radius : int
var d : float = 0.0

@export_category("mele type")
@export var sword : Area3D
@export var demage : int
@export var attack_speed : float
var attack_timer : float = 0.0

@export_category("mele type")

func _ready() -> void:
	super._ready()
	saved_player_position = position
	player = Global.player
	set_type_of_sceleton()

func _process(delta : float) -> void:
	super._process(delta)
	velocity = Vector3.ZERO
	# hunting and alarm
	if hunt:
		move_to_pos(player.position)
		attack_timer += attack_speed * delta
		if attack_timer >= 100:
			attack_timer = 0.0
			attack(delta, demage)
	elif !hunt and alarmed:
		if position.distance_to(saved_player_position) >= 1:
			move_to_pos(saved_player_position)
		else:
			alarmed = false
	else:	# if not alarmed or hunting then patrol
		do_patrol(delta)

func move_to_pos(pos : Vector3) -> void:
	velocity = Vector3.ZERO
	# use nav agent to find path to target
	nav_agent.set_target_position(pos)
	var next_nav_point : Vector3 = nav_agent.get_next_path_position()
	velocity = (next_nav_point - global_transform.origin).normalized() * speed
	move_and_slide()

func _on_vision_timer_timeout() -> void:
	hunt = false
	var overlaps = vision.get_overlapping_bodies()
	if overlaps.size() > 0:
		for overlap in overlaps:
			if overlap.name == "Player":
				alarmed = true
				vision_raycast.force_raycast_update()
				look_at(Vector3(player.position.x, 0.5, player.position.z), Vector3(0, 1, 0))
				if vision_raycast.is_colliding():
					var collider : Object = vision_raycast.get_collider()
					if collider.name == "Player":
						saved_player_position = player.position
						hunt = true

func do_patrol(delta : float) -> void:
	if patrol_mode == patrol.hold_position:
		# do circle to hold position
		d += delta
		velocity = Vector3(sin(d*speed)*radius, 0, cos(d*speed)*radius)
		move_to_pos(position+velocity)
		rotate_y(speed * delta)

	elif patrol_mode == patrol.prepared_patrol:
		# visit points seted at the start
		pass

func attack(delta : float, demage : int) -> void: 
	if sceleton_type == s_types.mele:	#mele
		print("mele")
		sword.rotate_y(speed * delta)
		var overlaps = vision.get_overlapping_bodies()
		if overlaps.size() > 0:
			for overlap in overlaps:
				if overlap.name == "Player":
					print("demage to player")
	elif sceleton_type == s_types.range:	#ranged
		print("range")

func set_type_of_sceleton() -> void:
	pass
