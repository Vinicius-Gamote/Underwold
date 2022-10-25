extends Area2D

var mov = Vector2(0,0)

func _process(delta):
	mov.x = 5.75
	translate(mov)


func _on_Timer_timeout():
	queue_free()
