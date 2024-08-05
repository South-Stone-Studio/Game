@icon("res://custom icons/slime.png")

class_name Slime

extends IEntity

var slam: bool
@export var movement: IMovement
@export var target: Node3D
var target_position: Vector3
@export var pathfinding: NavigationAgent3D
@export var vision: Vision
var base_state: State = State.standing

func _ready() -> void:
	state = base_state

func _process(_delta: float) -> void:
	match state:
		State.standing:
			pathfinding.target_position = self.global_position
			if len(vision.objects_in_sight) > 0:
				for i: Node3D in vision.objects_in_sight:
					if check_for_enemy(i):
						target = i
						print("swap to aware")
						state = State.aware
						target_position = target.global_position
						break
		State.agressive:
			if target:
				movement.look_at(Vector3(target.global_position.x, movement.global_position.y, target.global_position.z), Vector3.UP, true)
				pathfinding.target_position = target.global_position
			else:
				print("swap to aware")
				state = State.aware
		State.aware:
			if pathfinding.is_navigation_finished() and !target:
				print("swap to standing")
				state = base_state
			if target:
				movement.look_at(Vector3(target.global_position.x, movement.global_position.y, target.global_position.z),Vector3.UP, true)
				print("swap to agressive")
				state = State.agressive
	
func _physics_process(delta: float) -> void:
	if state == State.standing:
		movement.stand(delta)
	else:
		movement.move(delta, pathfinding.get_next_path_position())

func check_for_enemy(obj: Node3D) -> bool:
	return is_instance_of(obj.get_parent(), IEntity)
	
func _on_vision_object_enter(obj: Node3D) -> void:
	if check_for_enemy(obj): # zastąpić na Player po utworzeniu refactored gracza
		print(obj.name)
		target = obj
		state = State.aware
		target_position = obj.global_position
		print(obj.global_position)

func _on_vision_object_exit(obj: Node3D) -> void:
	if obj == target:
		print(obj.name)
		target = null
