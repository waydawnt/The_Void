extends CharacterBody3D

var enemy_health : int = 100
var enemy_speed : int = 3

@export var player_position : CharacterBody3D
@onready var blood_point = $EnemySprite/BloodPoint
@onready var state_machine = $AnimationTree.get("parameters/playback")
@onready var audio_player : AudioStreamPlayer = $AudioStreamPlayer

@onready var run_sfx = preload("res://sounds/run.mp3")

var direction : Vector3
var dead : bool = false
var is_running : bool = false


func _process(delta):
	if is_running:
		audio_player.play()
	else:
		audio_player.stop()



func _physics_process(delta):
	get_direction()
	play_animations()
	
	velocity = calculate_velocity(direction, velocity, delta)
	move_and_slide()


func get_direction():
	var player_x_position = roundi(player_position.global_position.x)
	var enemy_x_direction = roundi(global_position.x)
	
#	print("Player Position: " + str(player_x_position))
#	print("Enemy Position: " + str(enemy_x_direction))
	
	if player_x_position > enemy_x_direction:
		direction.x = 1
	elif  player_x_position < enemy_x_direction:
		direction.x = -1
	else:
		direction.x = 0

func calculate_velocity(dir, vel, delta):
	var new_vel = vel
	
	new_vel.x = dir.x * enemy_speed
	
	if direction.x == 0:
		new_vel.x = 0
	
	if dead:
		new_vel = Vector3.ZERO
	
	return new_vel


func play_animations():
	if !dead:
		if direction.x != 0:
			is_running = true
			if direction.x == 1:
				$EnemySprite.flip_h = false
				state_machine.travel("run")
			elif direction.x == -1:
				$EnemySprite.flip_h = true
				state_machine.travel("run")
		else:
			is_running = false
			state_machine.travel("attack")
	else:
		state_machine.travel("die")


func deal_damage(damage):
	var blood_splatter = load("res://scenes/player/blood_splatter.tscn").instantiate()
	blood_splatter.transform = blood_point.global_transform
	owner.add_child(blood_splatter)
	enemy_health -= damage
	if enemy_health <= 0:
		dead = true


func _on_attack_area_body_entered(body):
	if body.name == "Player":
		if !body.dead:
			body.camera_animation.play("camera_shake")
			body.hurt = true
			body.deal_damage()
