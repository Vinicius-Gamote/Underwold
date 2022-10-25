extends Node2D

var moedas_final = 0
var moedas_x2 = 0

func Update():
	
		if(ScriptGlobal.perk4 == 1):
			ScriptGlobal.moedas = ScriptGlobal.moedas + ScriptGlobal.moedas_jogo * 2
			ScriptGlobal.pontuacao = ScriptGlobal.pontuacao + ScriptGlobal.pontos_jogo * 2
		else:
			ScriptGlobal.moedas = ScriptGlobal.moedas + ScriptGlobal.moedas_jogo
			ScriptGlobal.pontuacao = ScriptGlobal.pontuacao + ScriptGlobal.pontos_jogo
		
		if(ScriptGlobal.mortes > 1):
			ScriptGlobal.pontuacao = ScriptGlobal.pontuacao - (ScriptGlobal.mortes * 2)
			if(ScriptGlobal.pontuacao < 0):
				ScriptGlobal.pontuacao = 0
			ScriptGlobal.moedas = ScriptGlobal.moedas - (ScriptGlobal.mortes * 2)
			if(ScriptGlobal.moedas < 0):
				ScriptGlobal.moedas = 0	
				
			ScriptGlobal.moedas_jogo = ScriptGlobal.moedas
			ScriptGlobal.pontos_jogo = ScriptGlobal.pontuacao

	
	
		$Total_Pontos.text = str(ScriptGlobal.pontos_jogo)
		$Total_Moedas.text = str(ScriptGlobal.moedas_jogo)
		$Total_Mortes.text = str(ScriptGlobal.mortes)
		$Total_Inimigos.text = str(ScriptGlobal.inimigos_mortos)
		$Perk4_Ativado/Pontos_Dobro_Final.text = str(moedas_x2)
		


func _ready():
		moedas_x2 = ScriptGlobal.moedas_jogo * 2
		if(ScriptGlobal.perk4 == 1):
			$Perk4_Ativado.visible = true
		else:
			$Perk4_Ativado.visible = false
		Update()

func _on_Button_pressed():
	$Pontos2.request(ScriptGlobal.globalhost + "update_pontuacao.php?pontuacao=" + str(ScriptGlobal.pontuacao) + "&username=" + ScriptGlobal.username, [], false, HTTPClient.METHOD_GET)
	$Moedas.request(ScriptGlobal.globalhost + "update_moedas.php?moedas=" + str(ScriptGlobal.moedas) + "&username=" + ScriptGlobal.username, [], false, HTTPClient.METHOD_GET)
	$Timer.start()
	$Button.disabled = true


func _on_Timer_timeout():
	ScriptGlobal.resetarjogo()
	get_tree().change_scene("res://Cenas/Cena_Menu.tscn")
