extends Area3D

@export var speed : float
@export var demage : int
var death_timer : float = 10.0

func _process(delta: float) -> void:
	translate(Vector3(0,0,-speed*delta))
	death_timer -= 0.1
	if death_timer <= 0:
		self.queue_free()

func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		Global.player.handle_demage(demage)
	
