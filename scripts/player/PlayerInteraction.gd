class_name PlayerInteraction

extends Area3D

var interaction: Interactable
@export var text: Label3D 
func _process(_delta: float) -> void:
	var interactable:Array[Node3D] = self.get_overlapping_bodies().filter(filter_interactable)
	if len(interactable) > 0:
		make_interactable(interactable)
		text.visible = true
		if Input.is_action_just_pressed("interact") and interaction:
			interaction.interact.emit()
	else:
		text.visible = false
		if interaction == null:
			return
		interaction.lowlight()
		interaction = null

func filter_interactable(n:Node3D) -> bool:
	return is_instance_of(n, Interactable) and !n.locked

func make_interactable(interactions: Array[Node3D]):
	var mi: Interactable
	for interaction in interactions:
		if interaction.priority:
			mi = interaction
	if mi == null:
		mi = interactions[0]
	mi.highlight()
	if interaction != mi and interaction != null:
		interaction.lowlight()
	interaction = mi
