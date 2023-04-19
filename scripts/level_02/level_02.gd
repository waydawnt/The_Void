extends Node3D


@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var music : AudioStream = preload("res://sounds/just_evil(cyberpunk).mp3")
@onready var audio_player : AudioStreamPlayer = $AudioPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fade_in":
		await get_tree().create_timer(1.0).timeout
		animation_player.play("establishing_shot")
#		audio_player.set_stream(music)
#		audio_player.play()
