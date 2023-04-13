extends CharacterBody3D

@export var walk_speed : int = 2
@export var acceleration : int = 10
@export var run_speed : int = 5

@onready var ammo : Label = $Control/BulletText
@export var total_bullet: int = 6
var current_bullet: int = 6
var is_reloading : bool = false


@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var player_sprite : Sprite3D = $PlayerSprite
@onready var muzzle_flash : Sprite3D = $PlayerSprite/Muzzle/Flash
@onready var camera : Camera3D = $Camera3D
@onready var barrel_point : Node3D = $PlayerSprite/Muzzle
@onready var state_machine = $AnimationTree.get("parameters/playback")
@onready var audio_player : AudioStreamPlayer = $AudioStreamPlayer

@onready var bullet_scene = preload("res://scenes/player/bullet.tscn")

@onready var pistol_shoot_sound : AudioStream = preload("res://sounds/pistol_shoot.mp3")
@onready var walk_sound : AudioStream = preload("res://sounds/walk.mp3")
@onready var run_sound : AudioStream = preload("res://sounds/run.mp3")

var vel : Vector3 = Vector3.ZERO
var bullet_direction : int = 1


func _process(delta):
	
	update_text()
	
	if Input.is_action_just_pressed("reload") or current_bullet == 0:
		if current_bullet < total_bullet:
			is_reloading = true
			current_bullet = total_bullet
			await get_tree().create_timer(2.0).timeout
			is_reloading = false


func _physics_process(delta):
	get_input(delta)
	move_and_slide()


# Player basic movements, animations and fire actions
func get_input(delta):
	var speed : int
	var direction : Vector3 = Vector3.ZERO
	
	# get and set X direction of Player
	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	if direction.x != 0:
		if direction.x < 0:
			player_sprite.flip_h = true
			muzzle_flash.flip_h = true
			barrel_point.transform.origin = Vector3(-0.7, 0.28, 0)
			bullet_direction = -1
		elif direction.x > 0:
			player_sprite.flip_h = false
			muzzle_flash.flip_h = false
			barrel_point.transform.origin = Vector3(0.7, 0.28, 0)
			bullet_direction = 1
		
		# multiply speed if shift is pressed
		if Input.is_action_pressed("run"):
			state_machine.travel("run")
			speed = 5
			movement_sfx("run")
		else:
			state_machine.travel("walk")
			speed = 2
			movement_sfx("walk")
	elif direction.x == 0:
		movement_sfx("stand")
		state_machine.travel("idle")
	
	# call shoot function and show muzzle flash
	if Input.is_action_pressed("fire") and not is_reloading:
		state_machine.travel("fire")
		movement_sfx("stand")
		shoot()
		set_physics_process(false)
	
	direction = direction.normalized()
	
	velocity = velocity.lerp(direction * speed, acceleration * delta)


# Pistol Shoot function
func shoot():
	current_bullet -= 1
	var clone = bullet_scene.instantiate()
	clone.player_direction = bullet_direction
	clone.transform.scaled(Vector3(10, 10, 10))
	owner.add_child(clone)
	clone.transform = barrel_point.global_transform
	shoot_sfx()
	muzzle_flash.show()
	await get_tree().create_timer(0.1).timeout
	muzzle_flash.hide()
	return


# Player Pistol shoot sound effect
func shoot_sfx():
	var audio = AudioStreamPlayer.new()
	add_child(audio)
	audio.set_stream(pistol_shoot_sound)
	audio.play()
	await get_tree().create_timer(2.0).timeout
	audio.queue_free()
	return


# Player walk and run sound effects
func movement_sfx(movement):
	if movement == "walk":
		if !audio_player.playing or audio_player.stream == run_sound:
			audio_player.play()
			if audio_player.stream == run_sound:
				audio_player.set_stream(walk_sound)
				audio_player.pitch_scale = 0.7
				audio_player.volume_db = -5
				audio_player.play()
	elif movement == "run":
		if !audio_player.playing or audio_player.stream == walk_sound:
			if audio_player.stream == walk_sound:
				audio_player.set_stream(run_sound)
				audio_player.pitch_scale = 0.8
				audio_player.volume_db = 20
				audio_player.play()
	elif movement == "stand":
		audio_player.stop()


# Update ammo text
func update_text():
	if is_reloading:
		ammo.text = "Reloading"
	else:
		ammo.text = str(current_bullet) + " / " + str(total_bullet)


func _on_animation_tree_animation_finished(anim_name):
	if anim_name == "fire":
		set_physics_process(true)
