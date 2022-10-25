extends Area2D


func _ready():
	$AnimatedSprite.play("Explosion")



func _on_AnimatedSprite_animation_finished():
	if($AnimatedSprite.animation == "Explosion"):
		queue_free()
