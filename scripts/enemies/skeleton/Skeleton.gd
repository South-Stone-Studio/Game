class_name EnemyMovement

extends Enemy

enum s_types {mele, range}
@export var sceleton_type : s_types 
@export var attack_timer : Timer
var is_attacking : bool

@export_category("vision")
@onready var player : CharacterBody3D
@export var vision : Area3D
@export var nav_agent : NavigationAgent3D
@export var vision_raycast : RayCast3D
var saved_player_position : Vector3

@export_category("patrol")
enum patrol {hold_position, prepared_patrol, bossfight}
@export var patrol_mode : patrol
@export var patrol_points : Array[Marker3D]
var hunt : bool = false
var alarmed : bool = false

@export_category("hold_position")
@export var radius : int
var d : float = 0.0

@export_category("mele type")
@export var sword : Area3D
@export var sword_demage : int
@export var attack_speed : float

@export_category("range type")
@export var bone_to_throw : Area3D
@export var bone_demage : int
@export var bone_throw_speed : float
@export var bone_heal : int

func _ready() -> void:
	super._ready()
	saved_player_position = position
	player = Global.player
	set_type_of_sceleton()

func _process(delta : float) -> void:
	super._process(delta)
	velocity = Vector3.ZERO
	
	if hunt:	#hunting
		move_to_pos(player.position)
		if not is_attacking:
			is_attacking = true
	elif !hunt and alarmed: 	#alarm
		if position.distance_to(saved_player_position) >= 1:
			move_to_pos(saved_player_position)
		else:
			alarmed = false
	else:	# if not alarmed or hunting then selected type of patrol
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
				if vision_raycast.is_colliding():
					var collider : Object = vision_raycast.get_collider()
					if collider.name == "Player":
						look_at(Vector3(player.position.x, 0.5, player.position.z), Vector3(0, 1, 0))
						saved_player_position = player.position
						hunt = true

func do_patrol(delta : float) -> void:
	if patrol_mode == patrol.hold_position:
		# do circle to hold position
		rotate_y(-1 * delta)
	elif patrol_mode == patrol.prepared_patrol:
		# visit points seted at the start
		pass

func attack() -> void:
	if sceleton_type == s_types.mele:	#mele
		print("mele")
		if not sword.do_atc:
			sword.do_atc = true
	elif sceleton_type == s_types.range:	#ranged
		print("range")
		

func set_type_of_sceleton() -> void:
	pass

func _on_sword_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		print("demage to player")


