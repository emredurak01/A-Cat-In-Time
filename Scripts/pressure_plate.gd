extends StaticBody2D

var pressed = false

func _ready():
	$green.visible = false
	$red.visible = true
	
func _process(delta):
	if($Area2D.get_overlapping_areas().is_empty() == true):
		pressed = false
		$green.visible = false
		$red.visible = true
		
	elif($Area2D.get_overlapping_areas().is_empty() == false):
		pressed = true
		$green.visible = true
		$red.visible = false
	

