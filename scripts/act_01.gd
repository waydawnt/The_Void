extends Node3D

const Ballon = preload("res://dialogues/balloon.tscn")

@onready var main_menu_scene = preload("res://scenes/main_menu/main_menu.tscn")
@onready var bus = preload("res://scenes/misc/bus.tscn")
@onready var bus_trigger_point : Node3D = $BusTriggerPoint
@onready var animation_player : AnimationPlayer = $AnimationPlayer


func _ready():
	animation_player.play("opening_fade_in")


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
		get_tree().change_scene_to_packed(main_menu_scene)
		queue_free()
