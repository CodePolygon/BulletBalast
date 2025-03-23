extends Control


func _on_p_pressed() -> void:
	get_tree().change_scene_to_file("res://level/level_gen.tscn")

func _on_e_pressed() -> void:
	get_tree().quit()

func _on_s_pressed() -> void:
	get_tree().change_scene_to_file("res://ui scene/setting.tscn")
