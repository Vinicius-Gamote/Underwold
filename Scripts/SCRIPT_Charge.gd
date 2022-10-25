extends KinematicBody2D

var mov = Vector2(0,0)
var speed = 390
var viuplayer = false
var atacar = false
var morreu = false
var vida = 225
var jump_force = 1500
var atacar_pos = Vector2(0,0)
var posicao_origem = global_position.x
var atacando = false
var animacao_morrendo = false
var voltarpos = false

func Dead():
	
	if(animacao_morrendo == false):
		$AnimatedSprite.play("Dead")
		mov.x = 0
		mov.y = 0
		ScriptGlobal.pontos_jogo += 50
		ScriptGlobal.moedas_jogo += 7
		ScriptGlobal.inimigos_mortos += 1
		animacao_morrendo = true

func VoltarPosicao():
	if(voltarpos == false):
		if(global_position.x < atacar_pos.x)or(global_position.x == atacar_pos.x):
			scale.x = -1
			mov.x = speed
		else:
			scale.x = 1
			mov.x = -speed
		voltarpos = true

func Atacar():
	$Area2D/CollisionShape2D.disabled = true
	$Charger_HitBox/ChargeCollision.disabled = false
	$AnimatedSprite.play("Attack")
	$FOVArea/FOVCollision.disabled = true
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
	voltarpos = false
	$Area2D/CollisionShape2D.disabled = false
	$FOVArea/FOVCollision.disabled = false


func _ready():
	posicao_origem = global_position.x

func _process(delta):
	mov.y += 2.5
	if(vida <= 0):
		morreu = true
		Dead()
	if(morreu == false):
		if(viuplayer == false):
			$AnimatedSprite.play("Idle")
		if (int(round(global_position.x)) <= int(round(atacar_pos.x))):
			VoltarPosicao()
		if(int(round(global_position.x)) >= int(round(posicao_origem + 1)))and(atacar==true):
			PararAtaque()
			global_position.x = posicao_origem
	move_and_slide(mov)


func _on_FOVArea_body_entered(body):
	if(body.name == "Player")and(viuplayer == false):
		viuplayer = true
		atacar_pos = ScriptGlobal.player_pos
		$AnimatedSprite.play("Pre_Attack")


func _on_AnimatedSprite_animation_finished():
	if($AnimatedSprite.animation == "Pre_Attack"):
		atacar = true
		Atacar()
	if($AnimatedSprite.animation == "Dead"):
		queue_free()


func _on_Area2D_body_entered(body):
	if(body.name == "Player")and(atacar == false)and(viuplayer == false)and(mov.x == 0):
		if(scale.x == -1):
			scale.x = 1
		else:
			scale.x = -1


func _on_HitBox_area_entered(area):
	if(area.name == "Tiro")and($AnimatedSprite.animation == "Attack"):
		area.queue_free()
		if(ScriptGlobal.perk2 == 1):
			vida -= 15 + (15 * 0.3)
		else:
			vida -= 15
