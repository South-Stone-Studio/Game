@icon("res://custom icons/slime.png")

class_name Slime

extends IEntity

var slam: bool
@export var movement: IMovement
@export var target: Node3D
@export var pathfinding: NavigationAgent3D
func _process(_delta: float) -> void:
	if target:
		pathfinding.target_position = target.global_position
	else:
		pathfinding.target_position = self.global_position
	
func _physics_process(delta: float) -> void:
	if pathfinding.is_navigation_finished():
		movement.stand(delta)
		return
	movement.move(delta, pathfinding.get_next_path_position())
