extends CharacterBody3D

@export var walk_speed : int = 2
@export var acceleration : int = 10
@export var run_speed : int = 5
@export var jump_force : int = 15
@export var gravity : float = 0.98

@onready var animation_player : Object = $AnimationPlayer
@onready var player_sprite : Object = $PlayerSprite
@onready var camera : Object = $Camera3D

var vel : Vector3 = Vector3.ZERO


func get_input(delta):
	var speed : int
	var direction : Vector3 = Vector3.ZERO

	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")

	if direction.x == 0 and !Input.is_action_just_pressed("fire"):
		animation_player.play("idle")
	elif direction.x > 0:
		player_sprite.flip_h = false
	elif direction.x < 0:
		player_sprite.flip_h = true

	if direction.x != 0:
		if Input.is_action_pressed("run"):
			animation_player.play("run")
			speed = 5
		else:
			animation_player.play("walk")
			speed = 2
	elif Input.is_action_just_pressed("fire"):
		animation_player.play("fire")
		await get_tree().create_timer(0.5).timeout

	direction = direction.normalized()
	print(direction)

	velocity = velocity.lerp(direction * speed, acceleration * delta)
	print(velocity)


func _physics_process(delta):
	get_input(delta)
	move_and_slide()
	
	
#	var dir = Input.get_axis("move_left", "move_right")
#
#	if dir != 0:
#		velocity.x = lerp(velocity.x, dir * spe)
