extends Node2D


@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var next_scene = preload("res://scenes/second_scene.tscn")


func _ready():
	animation_player.play("fade_out")
	await get_tree().create_timer(5.0).timeout
	animation_player.play("fade_in")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fade_in":
		get_tree().change_scene_to_packed(next_scene)
		queue_free()
