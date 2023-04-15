extends Node2D


@onready var animation_player : Object = $AnimationPlayer
@onready var main_menu = preload("res://scenes/main_menu/main_menu.tscn")


func _ready():
	animation_player.play("fade_out")
	await get_tree().create_timer(5.0).timeout
	animation_player.play("fade_in")


func play_audio():
	Global.audio_start()


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fade_in":
		get_tree().change_scene_to_packed(main_menu)
		queue_free()
