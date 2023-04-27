extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(8.0).timeout
	$AnimationPlayer.play("fade_out")
	


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fade_out":
		Global.next_scene = "res://scenes/level_02/level_02.tscn"
		get_tree().change_scene_to_file("res://scenes/misc/load.tscn")
		queue_free()
