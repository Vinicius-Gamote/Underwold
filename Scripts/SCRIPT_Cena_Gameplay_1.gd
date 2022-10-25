extends Node2D


func _process(delta):
	if not($AudioStreamPlayer.playing):
		$AudioStreamPlayer.play()


func _on_Area2D_body_entered(body):
	if(body.name == "Player"):
		body.global_position = $Outros_Porta/Porta_Saida.global_position
