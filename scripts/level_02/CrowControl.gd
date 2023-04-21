extends Node3D


func _on_area_left_area_entered(area):
	var parent = area.get_parent()
	if parent.is_in_group("civilian"):
		parent.flip()


func _on_area_right_area_entered(area):
	var parent = area.get_parent()
	if parent.is_in_group("civilian"):
		parent.flip()
