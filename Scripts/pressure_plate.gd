extends StaticBody2D

func _on_area_2d_area_entered(area):
	if(area != null):
		print("Pressed") 

func _on_area_2d_area_exited(area):
	if(area != null):
		print("Unpressed") 
