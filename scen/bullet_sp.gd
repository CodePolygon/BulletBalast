extends Node3D

@export var bullet_scene: PackedScene
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_released("ui_left"):
		spwn_bullet()
	if Input.is_action_just_released("ui_right"):
		spwn_bullet()
func spwn_bullet():
	if bullet_scene:
		var bullet = bullet_scene.instantiate() as RigidBody3D
		bullet.global_transform = global_transform
		get_parent().add_child(bullet)
