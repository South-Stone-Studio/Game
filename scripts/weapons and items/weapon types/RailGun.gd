class_name RailGun

extends BaseWeapon

@export var nozle: RayCast3D
var active: bool
@export var charge_up_time: float
var cur_cut: float


func _ready():
	pass

func primary(can: Callable, _start: bool = true):
	if !active and can.call():
		print("charging up!")
		active = true
		set_time_between_shot(time_between_shoots)
		cur_cut = charge_up_time
	

func _process(delta):
	super._process(delta)
	if active:
		if cur_cut != 0:
			cur_cut -= delta

func _physics_process(_delta):
	if active and cur_cut <= 0:
		print("shoot!")
		nozle.force_raycast_update()
		if nozle.is_colliding():
			var body = nozle.get_collider()
			if is_instance_of(body, Boss):
				body.health -= 30
			print(body.name)
		active = false
