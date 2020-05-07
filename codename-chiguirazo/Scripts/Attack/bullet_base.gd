extends KinematicBody2D

class_name bullet_base

#Atributos

export(float) var lifetime = 5
export(float) var speed = 500
export(float) var damage = 1

#Métodos

func Hurt(body):
	if body.has_method("Take_damage"):
		body.Take_damage(damage)

func Self_destruct():
	yield(get_tree().create_timer(lifetime),"timeout")
	set_process(false)
	queue_free()

func Motion():
	pass

func _On_body_collision(): #CONECTAR SEÑAL ON_BODY_ENTERED A ESTA FUNCIÓN
	pass