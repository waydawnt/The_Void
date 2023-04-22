extends Node

@onready var cut_scene = load("res://scenes/level_02/level_02.tscn")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "type_in":
		await get_tree().create_timer(10.0).timeout
		get_tree().change_scene_to_packed(cut_scene)
		queue_free()
