class_name Necro

extends Boss

@export var speed : float
@export var touch_demage : int
@export var spawn_sceletons_frequency : int
@export var distance_to_player : float
@export var ghost_demage : int
@export var rotation_speed : float

var ghost_ready : bool = false
var catch_player_ready : bool = false
var hp_control : int = health

@export var nav_agent : NavigationAgent3D
@export var raycast_aim : RayCast3D

@export var melee_sceleton : PackedScene
@export var ranged_sceleton : PackedScene

var player : CharacterBody3D

func _ready() -> void:
	player = Global.player

func _physics_process(delta: float) -> void:
	if position.distance_to(player.position) > distance_to_player:
		rotate_y(rotation_speed*delta) #	rotate head (with model rotate only head)
	else:
		move(player.position)




func move(pos):
	velocity = Vector3.ZERO
	nav_agent.set_target_position(pos)
	var next_nav_point : Vector3 = nav_agent.get_next_path_position()
	velocity = (next_nav_point - global_transform.origin).normalized() * speed
	move_and_slide()

# body enter
func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		body.handle_demage(touch_demage)
