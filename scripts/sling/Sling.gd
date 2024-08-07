@icon("res://custom icons/slime.png")

class_name Sling

extends Boss


var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

@export_category("Setup")
@onready var target: Node3D = Global.player
@export var shock_vave: PackedScene
@export var slimy_projectile: PackedScene
@export var show_danger: PackedScene
@export var my_scene: PackedScene

var primary: bool = true
var my_health: int
var primal: Sling = null
var devided: bool = false
var stasis: bool = false
var dople: Sling = null
@export_category("Sling Jumps")
@export var max_jumps: int = 5
@export var jumps_in_queue: int = 5
@export var coldown_after_jump: float = 2
@export var exhoustion_after_max_jump: float = 4
@export var speed: float = 5.0
@export var shock_wave_radius = 4.0
@export var offset_position: Vector2 = Vector2(0, 0)
@export var shock_wave_speed: float = 5

@export_category("Slimy Barrage")
@export var barages_in_queue: int = 3 
@export var number_of_bombs: Vector2i = Vector2i(4, 6)
@export var coldown_after_barage: float = 1.1
@export var bomb_speread: float = 5
@export var radius_of_barage_strike: float = 5

var current_jumps: int = 5
var coldown: float = 0
var target_position: Vector3

var is_in_sling_jump: bool
var create_shock_wave: bool

var queue: Array[Callable]
var index: int = 0

func _ready():
	if primary:
		label.visible = true
		boss_health_bar.visible = true
		super._ready()
	else:
		
		sling_jump()
	self.coldown = 2
	
	for i in range(jumps_in_queue):
		queue.append(sling_jump)
	for i in range(barages_in_queue):
		queue.append(slimy_barage)
	queue.shuffle()

func _process(delta: float) -> void:
	if stasis:
		return
	if coldown <= 0:
		if health <= max_health / 2 and !devided:
			devided = !devided
			devide_and_slime()
			coldown = 8
			return
		queue[index].call()
		index += 1
		index %= len(queue)
		if index == 0:
			queue.shuffle()
	else:
		coldown -= delta

func sling_jump():
	velocity.y = 20
	coldown = coldown_after_jump
	target_position = target.global_position
	if current_jumps == 0:
		coldown = exhoustion_after_max_jump
		current_jumps = max_jumps
	else:
		current_jumps -= 1
	is_in_sling_jump = true

func slimy_shock():
	var ex: Node3D = shock_vave.instantiate()
	ex = ex.duplicate()
	Global.current_room_root.add_child(ex)
	ex.global_position = self.global_position
	ex.max_radius = shock_wave_radius
	ex.speed = shock_wave_speed
	is_in_sling_jump = false
	create_shock_wave = false

func sling_movement():
	velocity.x = move_toward(0, target_position.x - self.global_position.x + offset_position.x, speed)
	velocity.z = move_toward(0, target_position.z - self.global_position.z + offset_position.y, speed)
	create_shock_wave = true

func slimy_barage():
	velocity.y = 10
	var r: ProceduralRoom = Global.current_room_root
	var width: Vector2 = Vector2(-2, (r.width * 10))
	var height: Vector2 = Vector2(-2, (r.height * 10))
	
	for i in range(randi_range(number_of_bombs.x, number_of_bombs.y)):
		var x: float = randf_range(-bomb_speread, bomb_speread)
		var y: float = randf_range(-bomb_speread, bomb_speread)
		var pos: Vector3 = Vector3(
			min(max(global_position.x+x,width.x),width.y), 0,
			min(max(global_position.z+y,height.x),height.y))
		var o: SlimyProjectile = slimy_projectile.instantiate().duplicate()
		var danger: Node3D = show_danger.instantiate().duplicate()
		
		Global.current_room_root.add_child(danger)
		Global.current_room_root.add_child(o)
		o.global_position = self.global_position + Vector3(0,2,0)
		danger.global_position = pos
		o.target_position = pos
		o.radius = radius_of_barage_strike
		o.obj_to_delete = danger
	coldown = coldown_after_barage
	
func devide_and_slime() -> void:
	dople = self.my_scene.instantiate()
	dople.health = health / 2
	dople.primary = false
	dople.primal = self
	self.my_health = health / 2
	self.offset_position = Vector2(6,0)
	dople.offset_position = Vector2(-6,0)
	dople.my_health = my_health
	dople.devided = true
	get_parent().add_child(dople)
	print("n: ", dople.my_health)
	print("p: ", my_health)
	
	dople.global_position = self.global_position

func _set_health(val: int):
	if devided:
		if primal != null:
			my_health = val
			health = val
			primal.health -= 0
		else:
			my_health = my_health - max(health-val, 0)
			health = my_health + dople.my_health
			boss_health_bar.health = (health * 100) / max_health
			if health <= 0:
				dople.queue_free()
				queue_free()
		if my_health <= 0:
			stasis = !stasis
			disable_mode = DISABLE_MODE_MAKE_STATIC
			self.global_position = Vector3(0, -10, 0)
	else:
		super._set_health(val)

func _physics_process(delta: float) -> void:
	velocity.x = 0
	velocity.z = 0
	if stasis:
		velocity.y = 0
		return
	if not is_on_floor():
		velocity.y -= gravity * delta * 3
		if is_in_sling_jump:
			sling_movement()
	else:
		if create_shock_wave and is_in_sling_jump:
			slimy_shock()
	move_and_slide()

#on body collision
func _on_area_3d_body_entered(body):
	if is_instance_of(body, PlayerMovement):
		print("Damage!")
