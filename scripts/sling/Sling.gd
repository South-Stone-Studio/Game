class_name Sling

extends CharacterBody3D


const SPEED = 5.0
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var target: Node3D = Global.player
@export var shock_vave: PackedScene
@export var slimy_bomb: PackedScene
var max_jumps = 5
var coldown: float = 0
var target_position: Vector3

#sling jump variables
var is_in_sling_jump: bool
var create_shock_wave: bool
var queue: Array[Callable]
var index: int = 0
func _ready():
	queue.append(sling_jump)
	queue.append(sling_jump)
	queue.append(slimy_barage)
	queue.append(sling_jump)

func _process(delta: float) -> void:
	if coldown <= 0:
		queue[index].call()
		index += 1
		index %= len(queue)
	else:
		coldown -= delta

func sling_jump():
	velocity.y = 20
	coldown = 2
	target_position = target.global_position
	if max_jumps == 0:
		coldown = 5
		max_jumps = 5
	else:
		max_jumps -= 1
	is_in_sling_jump = true

func slimy_shock():
	var ex: Node3D = shock_vave.instantiate()
	ex = ex.duplicate()
	Global.run_script.r.add_child(ex)
	ex.global_position = self.global_position
	is_in_sling_jump = false
	create_shock_wave = false

func sling_movement():
	velocity.x = move_toward(0, target_position.x - self.global_position.x, SPEED)
	velocity.z = move_toward(0, target_position.z - self.global_position.z, SPEED)
	create_shock_wave = true

func slimy_barage():
	velocity.y = 10
	var r: ProceduralRoom = Global.current_room_root
	var width: Vector2 = Vector2(5, (r.width * 10) - 5)
	var height: Vector2 = Vector2(5, (r.height * 10) - 5)
	var target_pos := target.global_position
	
	for i in range(randi_range(4, 6)):
		var x: float = randf_range(max(target_pos.x-5, width.x),min(target_pos.x+5, width.y))
		var y: float = randf_range(max(target_pos.z-5, height.x),min(target_pos.z+5, height.y))
		var pos: Vector3 = Vector3(x, 0, y)
		var delay: float = randf_range(0.2, 1.5)
		var o: SlimyBarageBomb = slimy_bomb.instantiate().duplicate()
		Global.current_room_root.add_child(o)
		o.global_position = pos
		print(target.global_position, o.global_position)
		o.delay = delay + 0.5
	coldown = 1.2
	
func rollin_goo() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	velocity.x = 0
	velocity.z = 0
	if not is_on_floor():
		velocity.y -= gravity * delta*3 # for faster landing
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
