extends Base_Player

var buffed = false

func _Level_up():
	
	if buffed:
		print("Imagina ganar stats gratis porque subiste de nivel mientras tus stats ya estaban aumentadas :D")
		yield($"Attaku System", "buff_finished") #Espera a que el buff termine para continuar
		print("Ora si, sube de lvl")
	
	._Level_up()
