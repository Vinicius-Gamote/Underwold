extends KinematicBody2D

var mov= Vector2(0,0)
#250
var velocidade= 250
var direcao= 1
#530
var jump_force= 530
var atirando= false
var pulando= false
var morrendo = true

func Atirar():
	if(morrendo == false):
		var tiro = preload("res://Cenas/Gameplay/Cena_Tiro.tscn").instance()
		tiro.global_position = $Tiro_Position.global_position
		if(direcao == -1):
			tiro.scale.x *= -1
		else:
			tiro.scale.x *= 1
		get_tree().root.add_child(tiro)
	

func VerificarPerks():
	if(ScriptGlobal.perk3 == 1):
		velocidade = velocidade + (velocidade * 0.3)
		jump_force = jump_force + (jump_force * 0.05)
		print(velocidade)
	if(ScriptGlobal.perk1 == 1):
		$Tiro_Timer.wait_time = 0.17

func Morrer():
	if(morrendo == false):
		morrendo = true
		if(ScriptGlobal.perk5 == 0):
			ScriptGlobal.mortes += 1
		$AnimatedSprite.play("Die")
		$PlayerHitBox/HitBox.disabled = false
		$DeadSound.play()

func _process(delta):
	if(morrendo == false):
		if(atirando == false):
			if(mov.x > 0) or (mov.x < 0):
				if(is_on_floor()):
					$AnimatedSprite.play("Run");
				else:
					$AnimatedSprite.play("Fall_Loop")
			else:
				if(is_on_floor()):
					$AnimatedSprite.play("Idle")
				else:
					$AnimatedSprite.play("Fall_Loop")
		else:
			if(mov.x == 0):
				if(is_on_floor()):
					$AnimatedSprite.play("Idle_Attack")
				else:
					$AnimatedSprite.play("Run_Attack")
			if(mov.x != 0):
				$AnimatedSprite.play("Run_Attack")

#########################################################################################
func _physics_process(delta):
		
	ScriptGlobal.player_pos = global_position
	if(morrendo == false):
		mov.x = 0;
		mov.y += 20;
		
		#### ------------- MOVIMENTAÇAO ---------------- ############
		if(Input.is_action_pressed("Dir")):
			if(direcao == -1):
				scale.x *= -1
				direcao = 1
			mov.x = velocidade;
			
		if(Input.is_action_pressed("Esq")):
			if(direcao == 1):
				scale.x *= -1
				direcao = -1
			mov.x = -velocidade;
		
		if(Input.is_action_just_pressed("jump"))and(is_on_floor()):
			mov.y -= jump_force
			
			
#########################################################################################
		if(Input.is_action_just_pressed("atirar")):
			atirando = true
			$Tiro_Timer.start()
			Atirar()

		if(Input.is_action_just_released("atirar")):
			atirando = false
			$Tiro_Timer.stop()
#########################################################################################
		mov = move_and_slide(mov,Vector2(0,-1))




func AtualizarHUD():
	if(ScriptGlobal.vida_player >= 2):
		$Camera2D/AnimatedSprite_Vida.play("Vida_Full")
	if(ScriptGlobal.vida_player == 1):
		$Camera2D/AnimatedSprite_Vida.play("Vida_Half")
	if(ScriptGlobal.vida_player <= 0):
		$Camera2D/AnimatedSprite_Vida.play("Vida_Empty")
		Morrer()


func _ready():
	$AnimatedSprite.play("Spawn")
	VerificarPerks()

func Animation_finished():
	if($AnimatedSprite.animation == "Die"):
		$AnimatedSprite.play("Spawn")
		ScriptGlobal.vida_player = 2
		position = ScriptGlobal.player_checkpoint
		AtualizarHUD()
	
	if($AnimatedSprite.animation == "Spawn"):
		$Camera2D.smoothing_enabled = false;
		morrendo = false;

func Area2D_area_entered(area):
	if(area.name == "Final"):
		get_tree().change_scene("res://Cenas/Cena_Final_da_Partida.tscn")
	if(area.name == "Death_Area"):
		ScriptGlobal.vida_player = 0
		AtualizarHUD()
		$Camera2D.smoothing_enabled = true;
		Morrer()
	if(area.name == "VoltarCheck"):
		position = ScriptGlobal.player_checkpoint
	
	######## Exploder ##########
	
	if(area.name == "ExHead")and(morrendo == false):
		mov.y -= jump_force + 500
		
	
	
	######## CHARGER ###########
	if(area.name == "HITBOXC") or (area.name == "Ghost") or (area.name == "HitExploder") or (area.name == "Explosion") and (morrendo == false):
		$PlayerHitBox/HitBox.disabled = true
		ScriptGlobal.vida_player = 0
		AtualizarHUD()
	
	######### TIRO ##############
	if(area.name == "Ghost_Tiro"):
		ScriptGlobal.vida_player -= 1
		AtualizarHUD()
		area.queue_free()
		


func Tiro_Timer_End():
	if(atirando == true):
		Atirar()
