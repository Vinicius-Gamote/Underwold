extends Node2D


func _process(delta):
	if(Input.is_action_just_pressed("PauseGame")):
		$ParallaxBackground/PauseScreen.visible = true
		get_tree().paused = true
