extends StaticBody2D

var pressed = false

func _ready():
	$green.visible = false
	$red.visible = true

func _on_area_2d_area_entered(area):
	if($Area2D.get_overlapping_areas() != null):
		pressed = true
		$green.visible = true
		$red.visible = false
	if($Area2D.get_overlapping_areas() == null):
		pressed = false
		$green.visible = false
		$red.visible = true

func _on_area_2d_area_exited(area):
	
	if($Area2D.get_overlapping_areas() != null):
		pressed = false
		$green.visible = false
		$red.visible = true
	if($Area2D.get_overlapping_areas() == null):
		pressed = true
		$green.visible = true
		$red.visible = false
