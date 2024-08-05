class_name SplashSlime

extends IEntity

var current_landing: int = 0
var temp_swap: Node3D

@export var jumps_to_atack: int = 3
@export var splashy_projectile: PackedScene
@export var num_of_prjectiles: int = 5
@export var projectile_speed: float = 10.0
@export var damage_on_projectile_contact: int = 10

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("move_up"):
		if state == State.patrol:
			state = State.atack
		else:
			state = State.patrol

func _on_landing() -> void:
	if state != State.atack:
		reset()
		return
	current_landing +=1
	current_landing %= jumps_to_atack
	if current_landing == 0:
		atack()
	if current_landing == 1:
		reset()

func atack() -> void:
	print("atack")
	var offset = + randi_range(0, 30)
	for i in range(num_of_prjectiles):
		var obj: Bullet = splashy_projectile.instantiate()
		obj.v = projectile_speed
		obj.exception.append(self)
		obj.damage = damage_on_projectile_contact
		get_parent().add_child(obj)
		obj.global_position = self.global_position + Vector3(0,0.5,0)
		obj.rotate_y(deg_to_rad(i* (360/num_of_prjectiles)+offset))
	temp_swap = target
	target = self

func reset() -> void:
	if temp_swap:
		target = temp_swap
