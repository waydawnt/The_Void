extends Node


@export var scene : String = "res://scenes/level_01/act_01.tscn"

@onready var progress_bar : ProgressBar = $Control/ProgressBar
@onready var enter_text : Label = $Control/EnterText

var scene_load_status = 0
var progress = []


func _ready():
	ResourceLoader.load_threaded_request(scene)


func _process(delta):
	scene_load_status = ResourceLoader.load_threaded_get_status(scene, progress)
	progress_bar.value = progress[0] * 100.0
	
	if scene_load_status == ResourceLoader.THREAD_LOAD_LOADED:
		enter_text.visible = true
		if enter_text.is_visible_in_tree():
			if Input.is_action_just_pressed("enter"):
				get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(scene))
				queue_free()
