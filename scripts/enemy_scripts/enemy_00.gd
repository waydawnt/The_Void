extends Node3D

var enemy_health : int = 100

@onready var blood_point = $EnemySprite/BloodPoint


func _ready():
	print(enemy_health)


func deal_damage(damage):
	var blood_splatter = load("res://scenes/player/blood_splatter.tscn").instantiate()
	blood_splatter.transform = blood_point.global_transform
	owner.add_child(blood_splatter)
	enemy_health -= damage
	if enemy_health == 0:
		queue_free()
