extends Area3D

var death_timer : float = 50.0
var necro : CharacterBody3D 

func _ready() -> void:
	necro = self.get_parent().get_parent()

func _process(delta: float) -> void:
	translate(Vector3(0,0,-necro.ghost_speed*delta))
	death_timer -= delta
	if death_timer <= 0:
		self.queue_free()

func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		Global.player.handle_demage(necro.ghost_demage)
