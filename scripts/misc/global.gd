extends Node

var next_scene : String

@onready var audio_player = AudioStreamPlayer.new()
@onready var main_music : AudioStream = preload("res://sounds/main_menu_music.mp3")


func _ready():
	add_child(audio_player)


func audio_start():
	audio_player.set_stream(main_music)
	audio_player.play()


func audio_stop():
	audio_player.stop()
	audio_player.queue_free()
