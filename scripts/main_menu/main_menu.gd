extends Node3D


@onready var wake_up : MeshInstance3D = $title/menu_options/WakeUp/wake_up
@onready var credits : MeshInstance3D = $title/menu_options/Credits/credits
@onready var sleep : MeshInstance3D = $title/menu_options/Sleep/sleep
@onready var options : Array = [wake_up, credits, sleep]

var current_index : int = 0

var selected_option

var yellow_neon = preload("res://materials/yellow_neon.tres")
var red_neon = preload("res://materials/red_neon.tres")


func _ready():
	$AnimationPlayer.play("fade_in")
	$AnimationPlayer.animation_finished.connect(modify)
	current_option(current_index)


func _process(delta):
	if Input.is_action_just_pressed("ui_down"):
		reset_previous(current_index)
		current_index += 1
		if current_index >= options.size():
			current_index = 0
	elif Input.is_action_just_pressed("ui_up"):
		reset_previous(current_index)
		current_index -= 1
		if current_index < 0:
			current_index = options.size() - 1
	
	if Input.is_action_just_pressed("ui_accept"):
		if current_index == 0:
			reset_previous(current_index)
			$AnimationPlayer.play("fade_out")
		elif current_index == 1:
			reset_previous(current_index)
			await get_tree().create_timer(1.0).timeout
		elif current_index == 2:
			reset_previous(current_index)
			$AnimationPlayer.play("fade_out")
	
	current_option(current_index)


func current_option(number):
	selected_option = options[number]
	selected_option.scale = Vector3(0.17, 0.17, 0.17)
	selected_option.set_surface_override_material(0, yellow_neon)


func reset_previous(number):
	var previous_option = options[number]
	previous_option.scale = Vector3(0.15, 0.15, 0.15)
	previous_option.set_surface_override_material(0, red_neon)
	return


func modify(anim_name):
	if anim_name == "fade_out":
		if current_index == 0:
			Global.next_scene = "res://scenes/level_01/act_01.tscn"
			Global.audio_stop()
			get_tree().change_scene_to_file("res://scenes/misc/load.tscn")
			queue_free()
		elif current_index == 1:
			pass
		elif current_index == 2:
			get_tree().quit()
