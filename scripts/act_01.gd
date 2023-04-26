extends Node3D

const Ballon = preload("res://dialogues/balloon.tscn")

@onready var bus = preload("res://scenes/misc/bus.tscn")
@onready var bus_trigger_point : Node3D = $BusTriggerPoint
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var player = $Player

@onready var goons_attack : Node3D = $GoonsAttack
@onready var goons_chat : Node3D = $GoonsChat

var bus_parent

func _ready():
	animation_player.play("opening_fade_in")


func _process(_delta):
	if State.take_aspirin:
		player.player_health = 100
		State.take_aspirin = false
	
	if player.dead:
		animation_player.play("dead_fade_out")
	
	if State.start_bus == true:
		start_bus()
		State.start_bus = false
	
	if $BusTimer.visible == true:
		$BusTimer.text = "Catch the bus\n" + str(round($Timer.time_left))
	
	if Global.got_on_bus == true:
		bus_parent.bus_speed = 6
		$Timer.stop()
		$BusTimer.visible = false
		$Player/PlayerSprite.visible = false
		player.set_physics_process(false)
		animation_player.play("next_level_fade_out_")
	
	if State.start_fight == true:
		animation_player.play("fight_fade_in")
		State.start_fight = false


func start_bus():
	var b = bus.instantiate()
	bus_trigger_point.add_child(b)
	State.start_bus = false


func _on_bus_trigger_body_entered(body):
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
	elif anim_name == "next_level_fade_out_":
		Global.next_scene = "res://scenes/main_menu/main_menu.tscn"
		get_tree().change_scene_to_file("res://scenes/misc/load.tscn")
		queue_free()
	elif anim_name == "fight_fade_in":
		animation_player.play("fight_fade_out")
		goons_chat.visible = false
		goons_attack.visible = true
	elif anim_name == "fight_fade_out":
		Global.goons_start_fight = true


func _on_bus_stop_area_entered(area):
	bus_parent = area.get_parent()
	if bus_parent.name == "Bus":
		bus_parent.animation_player.play("bus_idle")
		bus_parent.bus_speed = 0
		bus_parent.timer_started = true
		$BusTimer.visible = true
		$BusStop.queue_free()
		$Timer.start(30)


func _on_timer_timeout():
	bus_parent.bus_speed = 6
	animation_player.play("dead_fade_out")
	$BusTimer.visible = false
	$Timer.queue_free()
