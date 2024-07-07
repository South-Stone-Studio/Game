class_name MeleSceleton

extends Enemy

@export var attack_timer : Timer
@export var gravity : float
var is_attacking : bool
var target : CharacterBody3D

@export_category("vision")
@onready var player : CharacterBody3D
@export var nav_agent : NavigationAgent3D
@export var vision_controller : Node
var saved_player_position : Vector3

@export_category("patrol")
enum patrol {hold_position, prepared_patrol, bossfight}
@export var patrol_mode : patrol
@export var patrol_points : Array[Marker3D]
var hunt : bool = false
var alarmed : bool = false

@export_category("mele type")
@export var sword : Area3D
@export var sword_demage : int
@export var attack_speed : float

func _ready() -> void:
	super._ready()
	saved_player_position = position
	player = Global.player

func _physics_process(delta: float) -> void:
	super._process(delta)
	velocity = Vector3.ZERO
	velocity.y -= gravity * delta
	if player != null:
		if target != null:
			look_at(target.position)
			move_to_pos(target.position)
			attack()
		elif hunt:	#hunting
			move_to_pos(player.position)
			attack()
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

func do_patrol(delta : float) -> void:
	if patrol_mode == patrol.hold_position:
		# do circle to hold position
		rotate_y(-1 * delta)
	elif patrol_mode == patrol.prepared_patrol:
		# visit points seted at the start
		pass

# decide attack style 
func attack() -> void:
	sword.do_atc = true

# on raycast see player
func _on_vision_raycast_controller_player_seen() -> void:
	hunt = true
	look_at(Vector3(player.position.x,0.5,player.position.z))
	alarmed = true
	saved_player_position = player.position

# sword hit player
func _on_sword_player_in_sword() -> void:
	player.handle_demage(sword_demage)
