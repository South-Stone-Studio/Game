@tool
class_name Vision

extends Node3D

signal object_enter(Node3D)
signal object_exit(Node3D)
var objects_in_sight: Array[Node3D]

enum changed{num, distance, radius}
@export var rays: Array[RayCast3D]
@export var num_of_rays: int = 7:
	set(value):
		num_of_rays = value
		update_rays(changed.num)
@export var vision_distance: float = 10.0:
	set(value):
		vision_distance = value
		update_rays(changed.distance)
@export_range(0, 360) var radius: float = 130.0:
	set(value):
		radius = value
		update_rays(changed.radius)


func update_rays(chg: changed):
	match  chg:
		changed.distance:
			for ray: RayCast3D in rays:
				ray.target_position = Vector3(0,0,vision_distance)
			print("updated vision distance")
		changed.radius:
			reposition()
		changed.num:
			create_rays()
	pass
func _ready() -> void:
	if Engine.is_editor_hint():
		return
	object_enter.connect(test)
	object_exit.connect(test)
		
func _enter_tree() -> void:
	if !Engine.is_editor_hint():
		return
	create_rays()
	
func erase_rays():
	if !Engine.is_editor_hint():
		return
	var r := self.get_children()
	for ray in r:
		ray.free()
	rays.clear()
	
func create_rays():
	if !Engine.is_editor_hint():
		return
	erase_rays()
	print(rays)
	var ray: RayCast3D
	var half: float = radius/2
	for i in range(num_of_rays):
		ray = RayCast3D.new()
		add_child(ray)
		ray.set_owner(get_tree().edited_scene_root)
		rays.append(ray)
		ray.target_position = Vector3(0,0,vision_distance)
		ray.rotate_y(calc_degs(-half,half,float(i+0.5)/float(num_of_rays)))
func reposition():
	if !Engine.is_editor_hint():
		return
	var half: float = radius/2
	var i = 0;
	for ray in rays:
		ray.global_rotation_degrees = Vector3(0,0,0)
		ray.rotate_y(calc_degs(-half,half,float(i+0.5)/float(num_of_rays)))
		i+=1
		
func calc_degs(mi: float,mx: float,t: float) -> float:
	return deg_to_rad(lerp(mi,mx,t))

func _physics_process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
	var ar: Array[Node3D] = []
	for ray in rays:
		ray.force_raycast_update()
		var cur := ray.get_collider()
		if cur != null:
			if cur not in objects_in_sight:
				object_enter.emit(cur)
				objects_in_sight.append(cur)
			ar.append(cur)
	for obj in objects_in_sight:
		if obj not in ar:
			object_exit.emit(obj)
			objects_in_sight.erase(obj)
	
func test(i:Node3D):
	print(i.name)
