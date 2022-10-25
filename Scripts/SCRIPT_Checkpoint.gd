extends Area2D


var positionchk = Vector2(0,0)

func Checkpoint_entered(body):
	positionchk = body.position
	print("Checkpoint Salvo! == " + str(positionchk))
	ScriptGlobal.vida_player == 2
	ScriptGlobal.player_checkpoint = positionchk
