extends StaticBody2D

func _process(delta):
	if(find_child("pressure_plate").pressed):
		set_collision_layer_value(2, false)
	else:
		set_collision_layer_value(2, true)
	
