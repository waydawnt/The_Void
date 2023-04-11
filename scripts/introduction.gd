extends Node2D


@onready var animation_player : Object = $AnimationPlayer
@onready var loading_scene = preload("res://scenes/misc/load.tscn")


func _ready():
	animation_player.play("fade_out")
	
	await get_tree().create_timer(5.0).timeout
	print("finished")
	
	animation_player.play("fade_in")
	
	get_tree().change_scene_to_packed(loading_scene)
	queue_free()
