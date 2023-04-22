extends Node3D

@onready var main_menu = preload("res://scenes/main_menu/main_menu.tscn")

var next_scene_ready : bool = false

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var music : AudioStream = preload("res://sounds/just_evil(cyberpunk).mp3")
@onready var audio_player : AudioStreamPlayer = $AudioPlayer

@onready var player : Node3D = $Player
@onready var player_2 : Node3D = $Player2
@onready var player_animation : AnimationPlayer = $Player/AnimationPlayer

@onready var waitress : Node3D = $Waitress
@onready var waitress_animation : AnimationPlayer = $Waitress/AnimationPlayer

@export var player_speed : int = 2


func _ready():
	Global.audio_start()


func _physics_process(delta):
	player.global_position.x += player_speed * delta


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fade_in":
		await get_tree().create_timer(1.0).timeout
		animation_player.play("establishing_shot")
#		audio_player.set_stream(music)
#		audio_player.play()
	elif anim_name == "fade_out" and !player_2.visible and !waitress.visible and not next_scene_ready:
		player.hide()
		player_2.show()
		waitress.show()
		waitress_animation.play("walk")
		animation_player.play("fade_in_2")
	elif  anim_name == "fade_out" and player_2.visible and waitress.visible and not next_scene_ready:
		player_2.hide()
		waitress.hide()
		$Player/PlayerSprite.flip_h = true
		player.show()
		animation_player.play("fade_in_2")
	elif anim_name == "fade_in_2" and player.visible:
		player_animation.play("walk")
		player_speed = -2
		await get_tree().create_timer(5.0).timeout
		next_scene_ready = true
		animation_player.play("fade_out")
	elif anim_name == "fade_out" and next_scene_ready:
		get_tree().change_scene_to_packed(main_menu)


func _on_hotel_area_area_entered(area):
	if area.name == "PlayerArea":
		player_speed = 0
		player_animation.play("idle")
		$HotelArea.queue_free()
		animation_player.play("fade_out")


func _on_animation_waitress_animation_finished(anim_name):
	if anim_name == "walk":
		$Image.show()
		await get_tree().create_timer(5.0).timeout
		$Image.hide()
		animation_player.play("fade_out")
