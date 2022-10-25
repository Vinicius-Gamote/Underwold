extends Node2D

var info = ""

var host = ScriptGlobal.globalhost

func _ready():
	AtualizarLoja()
	
func comprarperk(preco):
	if(ScriptGlobal.moedas >= preco):
		return true;
	else:
		return false;
	

func AtualizarLoja():
	$HTTP_Moedas.request(host + "pegar_moedas.php?username=" + ScriptGlobal.username, [], false, HTTPClient.METHOD_GET)
	$HTTP_Pontos.request(host + "pegar_pontuacao.php?username=" + ScriptGlobal.username, [], false, HTTPClient.METHOD_GET)
	$HTTP_Perk1.request(host + "perk_1.php?username=" + ScriptGlobal.username, [], false, HTTPClient.METHOD_GET)
	$HTTP_Perk2.request(host + "perk_2.php?username=" + ScriptGlobal.username, [], false, HTTPClient.METHOD_GET)
	$HTTP_Perk3.request(host + "perk_3.php?username=" + ScriptGlobal.username, [], false, HTTPClient.METHOD_GET)
	$HTTP_Perk4.request(host + "perk_4.php?username=" + ScriptGlobal.username, [], false, HTTPClient.METHOD_GET)
	$HTTP_Perk5.request(host + "perk_5.php?username=" + ScriptGlobal.username, [], false, HTTPClient.METHOD_GET)


func _on_HTTP_Moedas_request_completed(result, response_code, headers, body):
	ScriptGlobal.moedas = int(body.get_string_from_utf8())
	$Loja/Moedas.text = body.get_string_from_utf8()


func _on_Perk1_pressed():
	if(comprarperk(300) == true):
		$HTTP_Comprar.request(host + "perk_comprada.php?Perk=perk_1&username=" + ScriptGlobal.username, [], false, HTTPClient.METHOD_GET)
		$HTTP_Moedas_Tirar.request(host + "update_moedas.php?moedas=" + str(ScriptGlobal.moedas - 300) + "&username=" + ScriptGlobal.username, [], false, HTTPClient.METHOD_GET)
		$AudioStreamPlayer.play()
		$Perk1.disabled = true
		$Timer.start()




func Perk1_request_completed(result, response_code, headers, body):
	if(int(body.get_string_from_utf8()) == 1):
		$Perk1.disabled = true
		$Perk1.text = "Ja Comprado"
		ScriptGlobal.perk1 = 1
	else:
		$Perk1.disabled = false

func Perk2_request_completed(result, response_code, headers, body):
	if(int(body.get_string_from_utf8()) == 1):
		$Perk2.disabled = true
		$Perk2.text = "Ja Comprado"
		ScriptGlobal.perk2 = 1
	else:
		$Perk2.disabled = false

func Perk3_request_completed(result, response_code, headers, body):
	if(int(body.get_string_from_utf8()) == 1):
		$Perk3.disabled = true
		$Perk3.text = "Ja Comprado"
		ScriptGlobal.perk3 = 1
	else:
		$Perk3.disabled = false

func Perk4_request_completed(result, response_code, headers, body):
	if(int(body.get_string_from_utf8()) == 1):
		$Perk4.disabled = true
		$Perk4.text = "Ja Comprado"
		ScriptGlobal.perk4 = 1
	else:
		$Perk4.disabled = false		

func Perk5_request_completed(result, response_code, headers, body):
	if(int(body.get_string_from_utf8()) == 1):
		$Perk5.disabled = true
		$Perk5.text = "Ja Comprado"
		ScriptGlobal.perk5 = 1
	else:
		$Perk5.disabled = false		


func _on_Perk2_pressed():
	if(comprarperk(150) == true):
		$HTTP_Comprar.request(host + "perk_comprada.php?Perk=perk_2&username=" + ScriptGlobal.username, [], false, HTTPClient.METHOD_GET)
		$HTTP_Moedas_Tirar.request(host + "update_moedas.php?moedas=" + str(ScriptGlobal.moedas - 150) + "&username=" + ScriptGlobal.username, [], false, HTTPClient.METHOD_GET)
		$AudioStreamPlayer.play()
		$Perk2.disabled = true
		$Timer.start()


func _on_Perk3_pressed():
	if(comprarperk(200) == true):
		$HTTP_Comprar.request(host + "perk_comprada.php?Perk=perk_3&username=" + ScriptGlobal.username, [], false, HTTPClient.METHOD_GET)
		$HTTP_Moedas_Tirar.request(host + "php/update_moedas.php?moedas=" + str(ScriptGlobal.moedas - 200) + "&username=" + ScriptGlobal.username, [], false, HTTPClient.METHOD_GET)
		$AudioStreamPlayer.play()
		$Perk3.disabled = true
		$Timer.start()


func _on_Perk4_pressed():
	if(comprarperk(500) == true):
		$HTTP_Comprar.request(host + "perk_comprada.php?Perk=perk_4&username=" + ScriptGlobal.username, [], false, HTTPClient.METHOD_GET)
		$HTTP_Moedas_Tirar.request(host + "update_moedas.php?moedas=" + str(ScriptGlobal.moedas - 500) + "&username=" + ScriptGlobal.username, [], false, HTTPClient.METHOD_GET)
		$AudioStreamPlayer.play()
		$Perk4.disabled = true
		$Timer.start()


func _on_Perk5_pressed():
	if(comprarperk(750) == true):
		$HTTP_Comprar.request(host + "perk_comprada.php?Perk=perk_5&username=" + ScriptGlobal.username, [], false, HTTPClient.METHOD_GET)
		$HTTP_Moedas_Tirar.request(host + "update_moedas.php?moedas=" + str(ScriptGlobal.moedas - 750) + "&username=" + ScriptGlobal.username, [], false, HTTPClient.METHOD_GET)
		$AudioStreamPlayer.play()
		$Perk5.disabled = true
		$Timer.start()


func _on_Timer_timeout():
	AtualizarLoja()
