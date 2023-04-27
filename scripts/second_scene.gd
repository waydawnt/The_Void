extends Node

var enter_pressed : bool = false


func _input(event):
	if not enter_pressed:
		if Input.is_action_just_pressed("enter"):
			$AnimationPlayer.play("type_in_2")
			enter_pressed = true


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "type_in":
		await get_tree().create_timer(10.0).timeout
		if not enter_pressed:
			$AnimationPlayer.play("type_in_2")
			enter_pressed = true
	elif anim_name == "type_in_2":
		await get_tree().create_timer(5.0).timeout
		get_tree().change_scene_to_file("res://scenes/news_screen.tscn")
		queue_free()
