extends Node


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "type_in":
		await get_tree().create_timer(10.0).timeout
		Global.next_scene = "res://scenes/level_02/level_02.tscn"
		get_tree().change_scene_to_file("res://scenes/misc/load.tscn")
		queue_free()
