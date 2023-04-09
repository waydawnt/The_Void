extends Node3D

var enemy_health : int = 100


func _ready():
	print(enemy_health)


func deal_damage(damage):
	enemy_health -= damage
	if enemy_health == 0:
		queue_free()
	print(enemy_health)
