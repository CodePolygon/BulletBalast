extends Node3D

@export var GRID_SIZE: int = 10
@export var BLOCK_SIZE: float = 2.0
@export var BLOCK_LIMIT: int = 50 
@export var STRAIGHT_PROBABILITY: float = 0.7
@export var REQUIRED_CONTACTS: int = 2
@export var ADD_FIRST_LAST_BLOCK: bool = true 

@export var block_scene: PackedScene 
@export var first_block_scene: PackedScene 
@export var last_block_scene: PackedScene

var grid = []
var directions = [Vector3.FORWARD, Vector3.BACK, Vector3.LEFT, Vector3.RIGHT]
var total_contact_blocks = 0
var path = []

@onready var world_environment: WorldEnvironment = $WorldEnvironment



func _ready():
	generate_tavel()
	place_blocks()
	print("Total Contact Blocks: ", total_contact_blocks)

func generate_tavel():
	grid = []
	for x in range(GRID_SIZE):
		grid.append([])
		for y in range(GRID_SIZE):
			grid[x].append(0)  

	path = []
	var start_pos = Vector3(randi() % GRID_SIZE, 0, randi() % GRID_SIZE)
	grid[start_pos.x][start_pos.z] = 1
	path.append(start_pos)
	total_contact_blocks = 1

	var last_direction = Vector3.ZERO

	while path.size() < BLOCK_LIMIT and path.size() < int((GRID_SIZE * GRID_SIZE) / 2):  
		if path.is_empty():
			break
		var current_pos = path[-1]
		var valid_moves = []
		
		for dir in directions:
			var new_pos = current_pos + dir
			if is_valid(new_pos):
				valid_moves.append(dir)
		
		if valid_moves.size() > 0:
			var next_dir
			if last_direction != Vector3.ZERO and randf() < STRAIGHT_PROBABILITY and last_direction in valid_moves:
				next_dir = last_direction
			else:
				next_dir = valid_moves[randi() % valid_moves.size()]
			
			var next_pos = current_pos + next_dir
			grid[next_pos.x][next_pos.z] = 1
			path.append(next_pos)
			total_contact_blocks += 1
			last_direction = next_dir
		else:
			path.pop_back() 

func is_valid(pos):
	if pos.x < 0 or pos.x >= GRID_SIZE or pos.z < 0 or pos.z >= GRID_SIZE:
		return false
	if grid[pos.x][pos.z] == 1:
		return false
	
	# Ensure it connects to the required number of blocks
	var neighbors = 0
	for dir in directions:
		var neighbor = pos + dir
		if neighbor.x >= 0 and neighbor.x < GRID_SIZE and neighbor.z >= 0 and neighbor.z < GRID_SIZE:
			if grid[neighbor.x][neighbor.z] == 1:
				neighbors += 1
	return neighbors == REQUIRED_CONTACTS

func place_blocks():
	for x in range(GRID_SIZE):
		for z in range(GRID_SIZE):
			if grid[x][z] == 1:
				var block
				if ADD_FIRST_LAST_BLOCK and path.size() > 1:
					if Vector3(x, 0, z) == path[0]:
						block = first_block_scene.instantiate()
					elif Vector3(x, 0, z) == path[-1]:
						block = last_block_scene.instantiate()
					else:
						block = block_scene.instantiate()
				else:
					block = block_scene.instantiate()
				
				block.transform.origin = Vector3(x * BLOCK_SIZE, 0, z * BLOCK_SIZE)
				add_child(block)


func _on_button_pressed() -> void:
	get_tree().reload_current_scene()



func _colour():
	world_environment.environment.sky.sky_material.pana
