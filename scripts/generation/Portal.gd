class_name Portal

extends Interactable

@export var orb: Node3D
@export var height: Vector2
var direction: int = 1
var offset: float = 0
func _on_interact() -> void:
	Global.map.visible = !Global.map.visible

func floating()->void:
	orb.position.y = sin(PI* float(direction)/100)*0.25 + offset

func _process(delta: float) -> void:
	floating()
	direction += 1
	direction = direction % 200
	if locked:
		offset = move_toward(offset, -2, delta*5)
	else:
		offset = move_toward(offset, 2, delta*5)
