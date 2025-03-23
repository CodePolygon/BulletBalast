extends CharacterBody3D

@export var shoot_force: float = 2.0
@export var rotate_speed: float = 2.0
@export var gravity: float = 9.8  # Gravity strength

func _physics_process(delta: float) -> void:
	# Apply gravity
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Smooth rotation
	var rotation_input = 0.0
	if Input.is_action_pressed("ui_left"):
		rotation_input += 1
	if Input.is_action_pressed("ui_right"):
		rotation_input -= 1

	rotation.y += rotation_input * rotate_speed * delta

	move_and_slide()  # Apply movement

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		shoot()

func shoot():
	var recoil_direction = global_transform.basis.z.normalized()
	velocity = -recoil_direction * shoot_force  # Apply recoil as velocity
	move_and_slide()  # Apply movement
