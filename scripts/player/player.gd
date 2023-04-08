extends CharacterBody3D

@export var walk_speed : int = 2
@export var acceleration : int = 10
@export var run_speed : int = 5
@export var jump_force : int = 15
@export var gravity : float = 0.98

@onready var animation_player : Object = $AnimationPlayer
@onready var player_sprite : Object = $PlayerSprite
@onready var camera : Object = $Camera3D
@onready var state_machine = $AnimationTree.get("parameters/playback")

var vel : Vector3 = Vector3.ZERO


func get_input(delta):
	var speed : int
	var direction : Vector3 = Vector3.ZERO

	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	if direction.x != 0:
		if direction.x < 0:
			player_sprite.flip_h = true
		elif direction.x > 0:
			player_sprite.flip_h = false
		
		if Input.is_action_pressed("run"):
			state_machine.travel("run")
			speed = 5
		else:
			state_machine.travel("walk")
			speed = 2
	else:
		state_machine.travel("idle")
	
	
	if Input.is_action_just_pressed("fire"):
		state_machine.travel("fire")

	direction = direction.normalized()

	velocity = velocity.lerp(direction * speed, acceleration * delta)


func _physics_process(delta):
	get_input(delta)
	move_and_slide()
