extends Node2D

class_name base_weapon

##Atributos##

export(float) var a_cooldown :float = 0.5 #Tiempo minimo entre disparos
export(int) var n_spread : int = 1 #Cantidad de balas por disparo
export(int) var a_spread : int= 5 #Separacion entre las balas/desviacion de disparo

##Métodos##

func Shoot() -> void:
	pass

func Reload() -> void:
	pass
