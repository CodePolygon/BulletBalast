extends MeshInstance3D

func _ready():
	var random_seed = randf()  # Generates a new random float between 0 and 1
	material_override.set_shader_parameter("seed", random_seed)
