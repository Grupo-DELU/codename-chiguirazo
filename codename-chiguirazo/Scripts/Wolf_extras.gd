extends Base_Player

var buffed = false

func _Level_up_call():
	
	if buffed:
		print("¿Quien necesita subir de nivel? ESTOY MAMADÍSIMO ÒwÓ")
		yield($"Attaku System", "buff_finished") #Espera a que el buff termine para continuar
		print("E-está bien, ahora si subiré de nivel UwU")
	
	._Level_up_call()
