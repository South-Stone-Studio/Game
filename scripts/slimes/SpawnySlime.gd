class_name SpawnnySlime

extends Slime


var current_landing: int = 0
var timeout: bool = false
@export var jumps_till_spawn: int = 5
@export var summon_per_spawn: int = 2
@export var slime: PackedScene
@export var timer: Timer

func _on_landing() -> void:
	current_landing += 1
	current_landing %=  jumps_till_spawn
	if current_landing == 0:
		spawn()

func _physics_process(delta: float) -> void:
	if timeout:
		return
	super._physics_process(delta)
	
func spawn():
	for i in range(summon_per_spawn):
		var obj: Slime = slime.instantiate()
		
		var offset: Vector3 = Vector3(
			randf_range(-3,3),
			0,
			randf_range(-3,3)
		)
		get_parent().add_child(obj)
		obj.global_position = self.global_position + Vector3(0,1.5,0)
		obj.target_position = self.global_position + offset
		obj.velocity.y = 10
		timeout = true
		timer.start()

func _on_timer_timeout() -> void:
	timeout = false
