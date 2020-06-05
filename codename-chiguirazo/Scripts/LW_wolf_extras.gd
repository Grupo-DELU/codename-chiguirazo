extends base_playeru

var buffed : bool= false

func Level_up_call()-> void:
	
	if buffed:
		print("¿Quien necesita subir de nivel? ESTOY MAMADÍSIMO ÒwÓ")
		yield($"Attack", "b_finished") #Espera a que el buff termine para continuar
		print("E-está bien, ahora si subiré de nivel UwU")
	
	.Level_up_call()
