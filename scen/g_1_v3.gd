extends RigidBody3D


@export var shoot_force: float = 0
@export var rotate_speed: float = 2.0
@onready var anim: AnimationPlayer = $AnimationPlayer


@onready var force_progress = $TextureProgressBar
@export var inc_force: float = 0.2
@export var force_limit: float = 10.0

@export var hard_mode:bool

func _ready() -> void:
	force_progress.max_value = force_limit

func _physics_process(delta: float) -> void:
	# Preserve the current position
	var current_position = global_transform.origin

	# Rotate the gun smoothly
	if Input.is_action_pressed("LEFT"):
		rotation.y += rotate_speed * delta
		shoot_force += inc_force
	if Input.is_action_pressed("RIGHT"):
		rotation.y -= rotate_speed * delta
		shoot_force += inc_force
	force_progress.value = shoot_force



	if Input.is_action_just_released("LEFT"):
		shoot()

	if Input.is_action_just_released("RIGHT"):
		shoot()


	# Restore position to prevent sinking
	global_transform.origin = current_position
	

	if shoot_force >= force_limit:
		if hard_mode == true:
			shoot()
		else :
			shoot_force = 0.0

func shoot():
	anim.play("fl")
	var recoil_direction = -global_transform.basis.z.normalized()
	apply_impulse(recoil_direction * shoot_force)  # Apply recoil force
	shoot_force = 1.0
	$shoot_soung.play()


func _on_check_button_toggled(toggled_on: bool) -> void:
	hard_mode = true
	
