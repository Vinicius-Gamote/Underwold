extends KinematicBody2D

var mov = Vector2(0,0)
var speed = 500
var viuplayer = false
var atacar = false
var morreu = false
var jump_force = 1500
var atacar_pos = Vector2(0,0)
var posicao_origem = global_position.x
var atacando = false
var animacao_morrendo = false

func Dead():
	
	if(animacao_morrendo == false):
		$AnimatedSprite.play("Dead")
		mov.x = 0
		mov.y = 0
		ScriptGlobal.pontos_jogo += 25
		ScriptGlobal.moedas_jogo += 5
		ScriptGlobal.inimigos_mortos += 1
		animacao_morrendo = true

func VoltarPosicao():
	if(global_position.x <= atacar_pos.x):
		scale.x = -1
		mov.x = speed
	else:
		scale.x = 1
		mov.x = -speed

func Atacar():
	$AnimatedSprite.play("Run")
	$FOV/CollisionShape2D.disabled = true
	if(atacar_pos.x <= global_position.x):
		scale.x = 1
		mov.x = -speed
	else:
		scale.x = -1
		mov.x = speed

func PararAtaque():
	mov.x = 0
	if(scale.x == -1):
		scale.x = 1
	else:
		scale.x = -1
	atacar_pos.x = 0
	atacar = false
	viuplayer = false
	$FOV/CollisionShape2D.disabled = false


func _ready():
	posicao_origem = global_position.x

func _process(delta):
	mov.y += 2.5
	if(morreu == false):
		if(viuplayer == false):
			$AnimatedSprite.play("Idle")
		if (int(round(global_position.x)) <= int(round(atacar_pos.x))):
			VoltarPosicao()
		if(int(round(global_position.x)) >= int(round(posicao_origem + 1)))and(atacar==true):
			PararAtaque()
			global_position.x = posicao_origem
	else:
		mov.x = 0
		mov.y = 0
		$FOV/CollisionShape2D.disabled = true
		$Area2D/CollisionShape2D.disabled = true
		$ExHead/CollisionShape2D.disabled = true
		$CollisionShape2D.disabled = true
		$HitExploder/CollisionShape2D.disabled = true
	move_and_slide(mov)



func _on_Area2D_body_entered(body):
	if(body.name == "Player")and(atacar == false)and(viuplayer == false)and(mov.x == 0):
		if(scale.x == -1):
			scale.x = 1
		else:
			scale.x = -1



func _on_FOV_body_entered(body):
	if(body.name == "Player")and(viuplayer == false):
		atacar = true
		viuplayer = true
		atacar_pos = ScriptGlobal.player_pos
		Atacar()




func _on_AnimatedSprite_animation_finished():
	if($AnimatedSprite.animation == "Dead"):
		var explosao = preload("res://Cenas/Inimigos/Cena_Explosao.tscn").instance()
		explosao.global_position.x = global_position.x
		explosao.global_position.y = global_position.y - 40
		get_tree().root.add_child(explosao)
		queue_free()



func _on_ExHead_area_entered(area):
	if(area.name == "PlayerHitBox"):
		Dead()
		morreu = true
