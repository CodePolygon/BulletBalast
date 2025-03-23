extends RigidBody3D

@export var speed: float = 0.1

@export var lifetime: float = 3.0  # Bullet disappears after this time

func _ready():
	# Automatically remove bullet after some time
	await get_tree().create_timer(lifetime).timeout
	queue_free()

func _physics_process(delta):
	self.position.z += speed
