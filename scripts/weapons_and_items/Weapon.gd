class_name Weapon

extends RigidBody3D

@export var Color_Mesh : MeshInstance3D
@export var picked : bool = false
@export var weapon: BaseWeapon
@export var ammo: Ammo

func _ready():
	if weapon == null:
		push_error("Node not specified: BaseWeapon, can find nodes inside weapon types.")
	if ammo == null:
		push_error("Node not specyfied: Ammo, can find nodes insidoe ammo types.")
	
func _input(event):
	if Input.is_action_just_pressed("attack") and picked:
		if ammo.can_shoot():
			weapon.primary()
	if Input.is_action_just_pressed("reload") and picked:
		if ammo.relodable:
			ammo.reload()
	if Input.is_action_just_pressed("alternative") and picked:
		weapon.alternative()

# GLOWING ON MOUSE ENTER #
func _on_mouse_entered():
	if not picked:
		Color_Mesh.visible = true

func _on_mouse_exited():
	Color_Mesh.visible = false

func disable_colision():
	$CollisionShape3D.disabled = !$CollisionShape3D.disabled
