extends RigidBody3D

@export var shoot_force: float = 10.0
@export var torque_force: float = 2.0

func _physics_process(delta):
	var torque_input = Vector3.ZERO

	# Rotate left/right (Y-axis)
	if Input.is_action_pressed("ui_left"):
		torque_input.y += torque_force
	if Input.is_action_pressed("ui_right"):
		torque_input.y -= torque_force

	# Rotate up/down (X-axis)
	if Input.is_action_pressed("ui_up"):
		torque_input.x += torque_force
	if Input.is_action_pressed("ui_down"):
		torque_input.x -= torque_force

	# Apply torque for smooth physics rotation
	apply_torque_impulse(torque_input)

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		shoot()
		
func shoot():
	var recoil_direction = -global_transform.basis.z.normalized()
	apply_impulse(recoil_direction * shoot_force)
