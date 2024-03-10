extends StaticBody2D

var pressed = false

func _on_area_2d_area_entered(area):
	if($Area2D.get_overlapping_areas() != null):
		pressed = true
	if($Area2D.get_overlapping_areas() == null):
		pressed = false

func _on_area_2d_area_exited(area):
	if($Area2D.get_overlapping_areas() != null):
		pressed = true
		
	if($Area2D.get_overlapping_areas() == null):
		pressed = false
