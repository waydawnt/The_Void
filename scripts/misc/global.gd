extends Node

var next_scene : String

@onready var audio_player = AudioStreamPlayer.new()
@onready var main_music : AudioStream = preload("res://sounds/just_evil(cyberpunk).mp3")


func _ready():
#	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	add_child(audio_player)


func audio_start():
	audio_player.set_stream(main_music)
	audio_player.play()


func audio_stop():
	audio_player.stop()
