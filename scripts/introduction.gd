extends Node2D


@onready var animation_player : Object = $AnimationPlayer


func _ready():
	animation_player.play("fade_out")
	
	await get_tree().create_timer(5.0).timeout
	print("finished")
	
	animation_player.play("fade_in")
