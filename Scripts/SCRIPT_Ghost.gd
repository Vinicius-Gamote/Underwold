extends Area2D

var morrendo = false
var vida = 100
var tiro_dano = 15
var atacar = false
var direcao = -1


func Atacar():
	if(morrendo == false) or (vida > 0):
		var tiro = preload("res://Cenas/Inimigos/Cena_Ghost_Tiro.tscn").instance()
		tiro.global_position = $Position2D.global_position
		$AnimatedSprite.play("Attack")
		if(scale.x < 0):
			tiro.scale.x *= -1
		else:
			tiro.scale.x *= 1
		get_tree().root.add_child(tiro)

func _physics_process(delta):
	if(morrendo == false):
		if(vida <= 0):
			$AnimatedSprite.play("Dead")
			morrendo = true
		if(atacar == true):
			if(ScriptGlobal.player_pos.x <= global_position.x):
				scale.x = -1
			else:
				scale.x = 1

func _on_Ghost_area_entered(area):
	if(area.name == "Tiro"):
		if(ScriptGlobal.perk2 == 1):
			vida -= tiro_dano + int((tiro_dano * 0.2))
		else:
			vida -= tiro_dano	


func _on_AnimatedSprite_animation_finished():
	if($AnimatedSprite.animation == "Dead"):
		ScriptGlobal.pontos_jogo += 10
		ScriptGlobal.moedas_jogo += 1
		ScriptGlobal.inimigos_mortos += 1
		queue_free()
	if($AnimatedSprite.animation == "Attack"):
		$AnimatedSprite.play("Idle")


func _on_Area2D_body_entered(body):
	if(body.name == "Player"):
		print("PLAYER DETECTADO")
		atacar = true
		$Timer.start()


func _on_Area2D_body_exited(body):
	if(body.name == "Player"):
		atacar = false
		$Timer.stop()


func _on_Timer_timeout():
	Atacar()
	pass
