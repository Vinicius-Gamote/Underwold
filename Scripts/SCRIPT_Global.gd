extends Node

##################### SERVER    ###########################

#https://underworldstudio.000webhostapp.com/php/
#http://underworldstudio.freeoda.com/php/

var globalhost = "http://underworldstudio.freeoda.com/php/"


###################### User Var ###########################
var username = ""
var user_level = 0
var pontuacao = 0
var player_checkpoint = Vector2(0,0)
var moedas = 0
var perk1 = 0
var perk2 = 0
var perk3 = 0
var perk4 = 0
var perk5 = 0
###########################################################
var loading_cena = "res://Cenas/Cena_LC.tscn"
var dying = true
###########################################################
var pontos_jogo = 0
var moedas_jogo = 0
var mortes = 0
var inimigos_mortos = 0
var player_pos = Vector2(0,0)
var vida_player = 2
###########################################################
func resetarjogo():
	pontos_jogo = 0
	moedas_jogo = 0
	inimigos_mortos = 0
	mortes = 0
	
