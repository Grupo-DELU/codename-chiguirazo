extends Node2D

class_name base_weapon

##Atributos##

export(float) var a_cooldown = 0.5 #Tiempo minimo entre disparos
export(int) var n_spread = 1 #Cantidad de balas por disparo
export(int) var a_spread = 5 #Separacion entre las balas/desviacion de disparo

##Métodos##

func Shoot():
	pass

func Reload():
	pass
