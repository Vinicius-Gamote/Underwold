extends Node2D




func _on_Voltar_Jogo_pressed():
	visible = false
	get_tree().paused = false


func _on_Voltar_Menu_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Cenas/Cena_Menu.tscn")
