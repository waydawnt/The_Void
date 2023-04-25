extends Node3D

@export var speed : float = 1
#@export var turn_time : int = 20

@onready var sprite : Sprite3D = $CivilianSprite
@onready var is_turned : bool = false


func _physics_process(delta):
#	position.x += speed * delta
	translate_object_local(Vector3(-speed * delta, 0, 0))
	
#	if not is_turned:
#		turn()


func turn():
	is_turned = true
#	await get_tree().create_timer(turn_time).timeout
	if sprite.flip_h == false:
		sprite.flip_h = true
		speed = -1
	else:
		sprite.flip_h = false
		speed = 1
	
	is_turned = false
	return

func flip():
	if sprite.flip_h == false:
		sprite.flip_h = true
		speed = -1
	else:
		sprite.flip_h = true
		speed = 1
