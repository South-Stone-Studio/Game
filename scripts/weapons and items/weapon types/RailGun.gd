class_name RailGun

extends IWeapon

@export var nozle: RayCast3D
var active: bool
@export var charge_up_time: float
var cur_cut: float


func _ready():
	pass



func _process(delta):
	pass

func _physics_process(_delta):
	if active and cur_cut <= 0:
		print("shoot!")
		nozle.force_raycast_update()
		if nozle.is_colliding():
			var body = nozle.get_collider()
			if is_instance_of(body, Boss):
				body.health -= damage
			print(body.name)
		active = false
