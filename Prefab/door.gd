extends StaticBody2D

func _process(delta):
	if(find_child("pressure_plate").pressed):
		#print("açık")
		set_collision_layer_value(2, false)
	else:
		#print("kapalı")
		set_collision_layer_value(2, true)
	
