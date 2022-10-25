extends Node2D

var host = ScriptGlobal.globalhost

var nome = ""
var pontos = ""
var level = ""
var pos = ""
var usernome = ScriptGlobal.username


func HTTPRequest_All():
	$Rank_Nome.request(host + "rank_nome.php",[],false,HTTPClient.METHOD_GET);
	$Rank_Level.request(host + "rank_level.php",[],false,HTTPClient.METHOD_GET);
	$Rank_Pontos.request(host + "rank_pontos.php",[],false,HTTPClient.METHOD_GET);
	$Rank_Pos.request(host + "rank_posicao.php",[],false,HTTPClient.METHOD_GET)
func _ready():
	HTTPRequest_All();



func Nome_request_completed(result, response_code, headers, body):
	nome = body.get_string_from_utf8();
	nome = nome.replace("<br>", "\n");
	#nome = nome.replace(".", "_");
	nome = nome.replace(str(usernome),"(Voce) " + str(usernome));
	print(usernome, nome);
	if(str(usernome) == str(nome)):
		print("IGUAL");
	$ScrollContainer/HBoxContainer/Label_Name.text = nome;
	nome = nome.find("	");
	
func Pontos_request_completed(result, response_code, headers, body):
	pontos = body.get_string_from_utf8();
	pontos = pontos.replace("<br>", "\n");
	$ScrollContainer/HBoxContainer/Label_Pontos.text = pontos;

func Level_request_completed(result, response_code, headers, body):
	level = body.get_string_from_utf8();
	level = level.replace("<br>", "\n");
	$ScrollContainer/HBoxContainer/Label_Level.text = level;


func _on_Rank_Pos_request_completed(result, response_code, headers, body):
	pos = body.get_string_from_utf8();
	pos = pos.replace("<br>", "\n");
	$ScrollContainer/HBoxContainer/Label_Posicao.text = pos;
	
