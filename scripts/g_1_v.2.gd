extends RigidBody3D

@export var shoot_force: float = 2.0
@export var rotate_speed: float = 2.0
@onready var anim: AnimationPlayer = $AnimationPlayer


func _physics_process(delta: float) -> void:
	# Preserve the current position
	var current_position = global_transform.origin

	# Rotate the gun smoothly
	if Input.is_action_pressed("ui_left"):
		rotation.y += rotate_speed * delta
	if Input.is_action_pressed("ui_right"):
		rotation.y -= rotate_speed * delta

	# Restore position to prevent sinking
	global_transform.origin = current_position

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		shoot()

func shoot():
	anim.play("fl")
	var recoil_direction = -global_transform.basis.z.normalized()
	apply_impulse(recoil_direction * shoot_force)  # Apply recoil force
