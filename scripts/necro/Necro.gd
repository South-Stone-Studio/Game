class_name Necro

extends Boss

@export var speed : float
@export var touch_demage : int
@export var spawn_sceletons_frequency : int
@export var distance_to_player : float
@export var distance_from_player : float
@export var rotation_speed : float
@export var active : bool = false
var ghost_ready : bool = false
var catch_player_ready : bool = false
var hp_control : int = health

@export_category("Catch Attack")
@export var catch_demage : int
@export var stunn_time : float
@export var stunn_delay_time : float
@export var catch_scene : PackedScene

@export_category('Ghost Attack')
@export var ghost_spawner : Marker3D
@export var ghost_scene : PackedScene
@export var ghost_speed : float
@export var ghost_demage : int

@export_category("Rest")
@export var head : MeshInstance3D
@export var nav_agent : NavigationAgent3D
@export var raycast_aim : RayCast3D

@export var melee_sceleton : PackedScene
@export var melee_sceleton_spawner : Marker3D
@export var ranged_sceleton : PackedScene
@export var ranged_sceleton_spawner : Marker3D

var player : CharacterBody3D

func _ready() -> void:
	player = Global.player
	spawn_sceletons()

func _physics_process(delta: float) -> void:
	if active and player != null:
		# position
		if position.distance_to(player.position) > distance_to_player:
			move(player.position+Vector3(0,1,0))
			head.rotate_y(rotation_speed*delta)
		elif position.distance_to(player.position) < distance_from_player:
			move(Vector3())	 #move in opposite way from player 
		
		#attacks
		if catch_player_ready:
			catch_attack()
			catch_player_ready = !catch_player_ready
		elif ghost_ready:
			ghost_attack()
			ghost_ready = !ghost_ready
		
		if health > 0 and max_health != health and (max_health - health)% 20 == 0:
			spawn_sceletons()
		
		look_at(player.position)

func spawn_sceletons() -> void:
	var ranged = ranged_sceleton.instantiate()
	var melee = melee_sceleton.instantiate()
	
	ranged.target = Global.player
	melee.target = Global.player
	
	ranged_sceleton_spawner.add_child(ranged)
	melee_sceleton_spawner.add_child(melee) 

func catch_attack() -> void:
	var catch : Area3D = catch_scene.instantiate()
	self.add_child(catch)

func ghost_attack() -> void:
	var ghost : Area3D = ghost_scene.instantiate()
	ghost_spawner.add_child(ghost)

func move(pos):
	velocity = Vector3.ZERO
	nav_agent.set_target_position(pos)
	var next_nav_point : Vector3 = nav_agent.get_next_path_position()
	velocity = (next_nav_point - global_transform.origin).normalized() * speed
	move_and_slide()

# body enter
func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "Player" :
		body.handle_demage(touch_demage)

func _on_wakeup_timer_timeout() -> void:
	active = true

func _on_attack_timer_timeout() -> void:
	var randomizer : int = randi_range(0,10)
	if randomizer % 2 == 0:
		self.catch_player_ready = true
	else:
		self.ghost_ready = true
