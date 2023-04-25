extends Node3D

const Ballon = preload("res://dialogues/balloon.tscn")

@onready var bus = preload("res://scenes/misc/bus.tscn")
@onready var bus_trigger_point : Node3D = $BusTriggerPoint
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var player = $Player


func _ready():
	animation_player.play("opening_fade_in")


func _process(delta):
	if State.take_aspirin:
		player.player_health = 100
		State.take_aspirin = false
	
	if player.dead:
		animation_player.play("dead_fade_out")


func _on_bus_trigger_body_entered(body):
	print(body.name)
	if body.name == "Player":
		var b = bus.instantiate()
		bus_trigger_point.add_child(b)
		$BusTrigger.queue_free()


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "opening_fade_in":
		var ballon = Ballon.instantiate()
		get_tree().current_scene.add_child(ballon)
		ballon.start(load("res://dialogues/act_01_dialogues.dialogue"), "start")
		return
	elif anim_name == "dead_fade_out":
		Global.audio_start()
		Global.next_scene = "res://scenes/main_menu/main_menu.tscn"
		get_tree().change_scene_to_file("res://scenes/misc/load.tscn")
		queue_free()
