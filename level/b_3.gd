extends Node3D


func _on_area_3d_body_entered(body: Node3D) -> void:
	print("finish")
	$Timer.start()


func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
