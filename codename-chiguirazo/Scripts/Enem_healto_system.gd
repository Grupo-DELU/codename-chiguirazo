extends Health_sys

onready var player = get_node("/root/Main/Player")

var experience = 18  #experiencia que da al murir

func _Die():    #Hace lo mismo que el base, además de dar exp al player
	send_xp()
	._Die()

func send_xp():  #Da experiencia al player xd
	print("Enemigo muerto: Enviados +" + str(experience) + " de experiencia")
	player.add_xp(experience)    