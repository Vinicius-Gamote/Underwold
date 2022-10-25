extends Node2D

func _process(delta):
	if not($Menu_OST.playing):
		$Menu_OST.play();
func _ready():
	$Fade.play("Fade_In", -1, 0.85);
	$HTTPRequest.request(ScriptGlobal.globalhost + "pegar_pontuacao.php?username=" + ScriptGlobal.username, [], false, HTTPClient.METHOD_GET)


func Rank_Voltar_pressed():
	$Menu.visible = true;
	$Rank.visible = false;


func Rank_pressed():
	$Rank.visible = true;
	$Menu.visible = false;


func Sair_pressed():
	get_tree().quit();


func Novo_Jogo_pressed():
	ScriptGlobal.loading_cena = "res://Cenas/Cena_Gameplay_1.tscn";
	$Fade.play_backwards("Fade_In");


func _on_Fade_animation_finished(anim_name):
	if($Fade.current_animation_position <= 0):
		get_tree().change_scene("res://Cenas/Cena_Loading.tscn");


func Loja_pressed():
	$Loja.visible = true;


func SairLoja_pressed():
	$Loja.visible = false;


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	ScriptGlobal.pontuacao = int(body.get_string_from_utf8())
