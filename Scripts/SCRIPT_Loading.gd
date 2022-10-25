extends Node2D

func _ready():
	$Loading_Timer.wait_time = rand_range(3,5);
	
func Loading_Complete():
	get_tree().change_scene(ScriptGlobal.loading_cena);
