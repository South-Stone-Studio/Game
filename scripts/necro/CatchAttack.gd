extends Area3D

var is_ready : bool = false
@export var delay_time : float 
var necro : CharacterBody3D 
@export var mesh : MeshInstance3D
var death_time : float

func _ready() -> void:
	self.position = Global.player.position + Vector3(0,-0.5,0)
	necro = self.get_parent()
	delay_time = necro.stunn_delay_time
	death_time = necro.stunn_time

func _process(delta: float) -> void:
	delay_time -= delta
	if delay_time <= 0 and is_ready == false : 
		is_ready = true
		var mesh_material = StandardMaterial3D.new()
		mesh_material.albedo_color = Color(1,0,0)
		mesh.set_surface_override_material(0, mesh_material)
		monitoring = true
	else: 
		death_time -= delta
	
	if death_time <= 0 :
		self.queue_free()
	

func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player" and is_ready:
		body.handle_demage(necro.catch_demage)
		body.stunned = true
