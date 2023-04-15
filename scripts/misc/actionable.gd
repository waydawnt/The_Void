extends Area3D

const Ballon = preload("res://dialogues/balloon.tscn")

@export var dialogue_resource : DialogueResource
@export var dialogue_start : String = "start"


func action() -> void:
	var ballon = Ballon.instantiate()
	get_tree().current_scene.add_child(ballon)
	ballon.start(dialogue_resource, dialogue_start)
	return
