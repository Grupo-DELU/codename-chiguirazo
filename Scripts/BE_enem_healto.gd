extends healto_base

onready var player : Node2D = get_node("/root/Main/Player")

var experience : float = 18  #experiencia que da al murir

func Die():    #Hace lo mismo que el base, además de dar exp al player
	send_xp()
	.Die()

func send_xp()-> void:  #Da experiencia al player xd
	print("Enemigo muerto: Enviados +" + str(experience) + " de experiencia")
	player.add_xp(experience)    