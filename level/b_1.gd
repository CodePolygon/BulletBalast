extends Node3D

@onready var re_spawn: Node3D = $re_spawn
@onready var g_1: RigidBody3D = $g1






func _on_area_3d_area_entered(area: Area3D) -> void:
		$Anim.play("RESP")
