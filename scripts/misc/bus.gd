extends Node3D

@export var bus_speed : int = 6

var timer_started : bool = false

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var audio_player : AudioStreamPlayer3D = $AudioStreamPlayer3D

@onready var bus_idle_sound : AudioStream = preload("res://sounds/bus_idle.mp3")
@onready var bus_run_sound : AudioStream = preload("res://sounds/bus_run.mp3")


func _process(_delta):
	if timer_started == true:
		$Area3D.monitoring = true


func _physics_process(delta):
#	audio_player.set_stream(bus_run_sound)
#	audio_player.play()
	if bus_speed != 0:
		animation_player.play("bus_run")
		position.x += bus_speed * delta


func _on_area_3d_body_entered(body):
	if body.name == "Player":
		Global.got_on_bus = true
