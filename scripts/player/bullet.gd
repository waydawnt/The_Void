extends Area3D


var bullet_speed : int = 25
var bullet_damage : int = 20
var direction : Vector3


const KILL_TIMER : float = 10
var timer : float = 0

var hit_something : bool = false

var player_direction


func _physics_process(delta):
	if player_direction > 0:
		direction = transform.basis.x * bullet_speed
	else:
		direction = -transform.basis.x * bullet_speed
	
	transform.origin += direction * delta
	
	timer += delta
	if timer >= KILL_TIMER:
		queue_free()


func _on_body_entered(body):
	var parent = body.get_parent()
	print(parent)
	if hit_something == false:
		if parent.has_method("deal_damage"):
			parent.deal_damage(bullet_damage)
