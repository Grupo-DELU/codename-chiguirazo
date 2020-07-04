extends "res://Scripts/BP_base_player.gd"

var buffed : bool= false

#For child node use
export(float) var buff_duration :float = 1

func Level_up_call()-> void:
	
	if buffed:
		print("¿Quien necesita subir de nivel? ESTOY MAMADÍSIMO ÒwÓ")
		yield(Attack.get_node("Skill1"), "b_finished") #Espera a que el buff termine para continuar
		print("E-está bien, ahora si subiré de nivel UwU")
	
	.Level_up_call()

func update_stats():
	.update_stats()
	Attack.get_node("Skill1/BDuration").wait_time = buff_duration