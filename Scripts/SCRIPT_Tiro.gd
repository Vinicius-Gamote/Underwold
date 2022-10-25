extends Area2D

var tiro_speed = 15
var mov = Vector2(0,0)

func _ready():
	if(ScriptGlobal.perk1 == 1):
		tiro_speed = tiro_speed + 10

func _process(delta):
	mov.x = tiro_speed
	translate(mov)


func _on_Timer_timeout():
	queue_free()


func _on_Tiro_area_entered(area):
	if(area.name == "TiroLimite"):
		queue_free()
	if(area.name == "Ghost"):
		queue_free()
	
