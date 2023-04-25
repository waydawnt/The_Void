extends Sprite3D


@export var speed : int = 1


func _physics_process(delta):
	translate_object_local(Vector3(-speed * delta, 0, 0))
