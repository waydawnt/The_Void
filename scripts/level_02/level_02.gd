extends Node3D


@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var music : AudioStream = preload("res://sounds/just_evil(cyberpunk).mp3")
@onready var audio_player : AudioStreamPlayer = $AudioPlayer

@onready var player : Node3D = $Player
@onready var player_2 : Node3D = $Player2
@onready var player_animation : AnimationPlayer = $Player/AnimationPlayer

@export var player_speed : int = 2


func _physics_process(delta):
	player.global_position.x += player_speed * delta


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fade_in":
		await get_tree().create_timer(1.0).timeout
		animation_player.play("establishing_shot")
#		audio_player.set_stream(music)
#		audio_player.play()
	elif anim_name == "fade_out":
		player.hide()
		player_2.show()
		animation_player.play("fade_in_2")


func _on_hotel_area_area_entered(area):
	if area.name == "PlayerArea":
		player_speed = 0
		player_animation.play("idle")
		$HotelArea.queue_free()
		animation_player.play("fade_out")
