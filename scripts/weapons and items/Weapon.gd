class_name Weapon

extends RigidBody3D

enum weapon_type{basic, continious}

signal force_reload

@export var Color_Mesh : MeshInstance3D
@export var picked : bool = false
@export var weapon: BaseWeapon
@export var ammo: Ammo
@export var type: weapon_type = weapon_type.basic

func _ready():
	if weapon == null:
		push_error("Node not specified: BaseWeapon, can find nodes inside weapon types.")
	if ammo == null:
		push_error("Node not specyfied: Ammo, can find nodes insidoe ammo types.")
	
func _input(_event):
	if not picked:
		return
	if Input.is_action_just_pressed("attack"):
		weapon.primary(ammo.can_shoot)
	if Input.is_action_just_released("attack") and type == weapon_type.continious:
		weapon.primary(ammo.can_shoot, false)
	if Input.is_action_just_pressed("reload"):
		if ammo.relodable:
			print("reloading")
			force_reload.emit()
			ammo.reload()
	if Input.is_action_just_pressed("alternative"):
		weapon.alternative()

# GLOWING ON MOUSE ENTER #
func _on_mouse_entered():
	if not picked:
		Color_Mesh.visible = true

func _on_mouse_exited():
	Color_Mesh.visible = false

func disable_colision():
	$CollisionShape3D.disabled = !$CollisionShape3D.disabled
