extends Node3D

@export var bus_speed : int = 5

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var audio_player : AudioStreamPlayer3D = $AudioStreamPlayer3D

@onready var bus_idle_sound : AudioStream = preload("res://sounds/bus_idle.mp3")
@onready var bus_run_sound : AudioStream = preload("res://sounds/bus_run.mp3")


func _physics_process(delta):
#	audio_player.set_stream(bus_run_sound)
#	audio_player.play()
	animation_player.play("bus_run")
	position.x += bus_speed * delta
