extends StaticBody2D

func _ready():
	$closed.visible = true
	$out.visible = false
	$in.visible = false

func _process(delta):
	if(find_child("pressure_plate").pressed and find_child("pressure_plate2").pressed):
		set_collision_layer_value(2, false)
		$closed.visible = false
		$out.visible = true
		$in.visible = true
	else:
		set_collision_layer_value(2, true)
		$closed.visible = true
		$out.visible = false
		$in.visible = false
	
