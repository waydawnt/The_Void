extends CharacterBody3D

@export var walk_speed : int = 2
@export var acceleration : int = 10
@export var run_speed : int = 5
@export var jump_force : int = 15
@export var gravity : float = 0.98

@onready var animation_player : Object = $AnimationPlayer
@onready var player_sprite : Object = $PlayerSprite
@onready var camera : Object = $Camera3D
@onready var barrel_point : Object = $PlayerSprite/Muzzle
@onready var state_machine = $AnimationTree.get("parameters/playback")

@onready var bullet_scene = preload("res://scenes/player/bullet.tscn")

var vel : Vector3 = Vector3.ZERO
var bullet_direction : int = 1


func _physics_process(delta):
	get_input(delta)
	move_and_slide()


# Player basic movements, animations and fire actions
func get_input(delta):
	var speed : int
	var direction : Vector3 = Vector3.ZERO
	
	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	if direction.x != 0:
		if direction.x < 0:
			player_sprite.flip_h = true
			barrel_point.transform.origin = Vector3(-0.6, 0.28, 0)
			bullet_direction = -1
		elif direction.x > 0:
			player_sprite.flip_h = false
			barrel_point.transform.origin = Vector3(0.6, 0.28, 0)
			bullet_direction = 1
		
		
		if Input.is_action_pressed("run"):
			state_machine.travel("run")
			speed = 5
		else:
			state_machine.travel("walk")
			speed = 2
	elif direction.x == 0:
		state_machine.travel("idle")
	
	if Input.is_action_pressed("fire"):
		state_machine.travel("fire")
		shoot()
		set_physics_process(false)
	
	direction = direction.normalized()
	
	velocity = velocity.lerp(direction * speed, acceleration * delta)


# Pistol Shoot function
func shoot():
	var clone = bullet_scene.instantiate()
	clone.player_direction = bullet_direction
	clone.transform.scaled(Vector3(10, 10, 10))
	owner.add_child(clone)
	clone.transform = barrel_point.global_transform
	return


func _on_animation_tree_animation_finished(anim_name):
	if anim_name == "fire":
		set_physics_process(true)
