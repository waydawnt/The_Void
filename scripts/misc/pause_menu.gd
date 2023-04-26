extends ColorRect


@onready var animation_player : AnimationPlayer = $AnimationPlayer

@onready var is_paused : bool = false


func _unhandled_input(event):
	if event.is_action_pressed("escape") and is_paused == false:
		pause()
		is_paused = true
	elif event.is_action_pressed("escape") and is_paused == true:
		unpause()
		is_paused = false


func pause():
	visible = true
	animation_player.play("pause_start")
	get_tree().paused = true


func unpause():
	animation_player.play("pause_stop")
	get_tree().paused = false


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "pause_stop":
		visible = false
