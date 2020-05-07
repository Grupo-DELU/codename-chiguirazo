extends Node2D

class_name Attack_sys

#Atributos
export(float) var cooldown = 0.5

#Métodos:
func Attack():
	pass

func spawn_projectile(projectile : Node2D, dir : Vector2):
	
	var attack = projectile.instance()
	
	attack.direction = dir
	attack.position = $Shoot_position.get_global_position()
	attack.rotation = Vector2(1,0).angle_to(dir)
	
	get_node("root/Main").add_child(attack)

