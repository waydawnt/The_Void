extends Node


@export var scene : String = "res://scenes/level_01/act_01.tscn"

@onready var progress_bar : ProgressBar = $Control/ProgressBar

var scene_load_status = 0
var progress = []


func _ready():
	ResourceLoader.load_threaded_request(scene)


func _process(delta):
	scene_load_status = ResourceLoader.load_threaded_get_status(scene, progress)
	progress_bar.value = progress[0] * 100
	
	if scene_load_status == ResourceLoader.THREAD_LOAD_LOADED:
		get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(scene))
		queue_free()
