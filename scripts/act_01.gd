extends Node3D


@onready var bus = preload("res://scenes/misc/bus.tscn")
@onready var bus_trigger_point : Node3D = $BusTriggerPoint


func _on_bus_trigger_body_entered(body):
	print(body.name)
	if body.name == "Player":
		var b = bus.instantiate()
		bus_trigger_point.add_child(b)
		$BusTrigger.queue_free()
