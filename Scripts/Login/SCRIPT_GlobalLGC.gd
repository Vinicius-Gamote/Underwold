extends Node2D

var main_link     = ScriptGlobal.globalhost
var login_var     = ""
var cadastrar_var = ""
var httplink      = ""
var status        = false
var verifique     = false
var cheat_moedas  = 1

func ShowPPU(errortitle="", errormessage=""):
	$Popup.visible = true;
	$Global.visible = false;
	$Cadastro.visible = false;
	$Popup/Label_PPU_Message.text = errormessage;
	$Popup/Label_PPU_Title.text   = errortitle;

func ShowLogin():
	$Login.visible = true;
	$Cadastro.visible = false;
	$Popup.visible = false;
	$Global.visible = true;
	$Global/B_Login.text = "Login";
	$Global/LB_Cadastrar.text = "Cadastrar";

func Login():
	login_var = "login.php?username=" + $Global/LE_Username.text + "&password=" + $Global/LE_Senha.text;
	httplink  = main_link + login_var;
	status= false;
	print(httplink);
	$HTTPRequest.request(httplink, [], false, HTTPClient.METHOD_GET);

func ShowCadastro():
	$Login.visible = false;
	$Cadastro.visible = true;
	$Popup.visible = false;
	$Global.visible = true;
	$Global/B_Login.text = "Cadastrar-se";
	$Global/LB_Cadastrar.text = "Log In";

func Cadastrar():
	if(cheat_moedas == 1):
		cadastrar_var = "cadastrar.php?email=" + $Cadastro/LE_Email.text + "&password=" + $Global/LE_Senha.text + "&username=" + $Global/LE_Username.text + "&level=1" +"&pontuacao=0&moedas=0";
	else:
		cadastrar_var = "cadastrar.php?email=" + $Cadastro/LE_Email.text + "&password=" + $Global/LE_Senha.text + "&username=" + $Global/LE_Username.text + "&level=1" +"&pontuacao=0&moedas=1000000";
	httplink = main_link + cadastrar_var;
	print(httplink);
	status = true;
	$HTTPRequest.request(httplink, [], false, HTTPClient.METHOD_GET);

func Login_pressed():
	if($Global/B_Login.text == "Login"):
		if($Global/LE_Username.text != ""):
			Login();
		else:
			ShowPPU("Falha no Login", "Verifique seu nome de usuario ou senha e tente novamente.");
	else:
		if($Global/LE_Username.text == ""):
			$Cadastro/Label_Warning.visible = true;
		else:	
			Cadastrar();

func Cadastrar_pressed():
	if($Global/LB_Cadastrar.text == "Cadastrar"):
		ShowCadastro();
	else:
		ShowLogin();	

func MostrarSenha():
	if($Global/CB_Senha.pressed == true):
		$Global/LE_Senha.secret = false;
	else:
		$Global/LE_Senha.secret = true;

func _Okay_pressed():
	if($Global/LB_Cadastrar.text == "Cadastrar"):
		ShowLogin();
	else:
		ShowCadastro();	
	
func _on_AnimationPlayer_animation_finished(anim_name):
	ScriptGlobal.loading_cena = "res://Cenas/Cena_Menu.tscn";
	get_tree().change_scene("res://Cenas/Cena_Loading.tscn");

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var resultado = body.get_string_from_utf8();
	resultado = resultado.replace("	","");
	if(status == false):
		resultado = resultado.replace("	","");
		if(resultado!="Invalido!"):
			$AnimationPlayer.play("Fade_oUT");
			ScriptGlobal.username = resultado;
		else:
			ShowPPU("Falha no Login", "Verifique seu nome e senha e tente novamente.");
	else:
		print(resultado);
		if(resultado == "Falha"):
			ShowPPU("Falha no Cadastro", "Ja existe um usuario com esse nome :(");
		else:
			ScriptGlobal.username = $Global/LE_Username.text;
			print(ScriptGlobal.username)
			$AnimationPlayer.play("Fade_oUT");
