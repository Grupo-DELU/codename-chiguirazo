extends Attack_sys

class_name enem_attack

#Atributos
var speed = get_parent().speed
var rate_of_fire  = 3

var fire_direction


#Métodos
func Attack_check():
	pass

func Attack(target: Vector2):
	can_attack = false
	speed = 0
	#fire_direction = (get_angle_to(player_position)/3.14)*100
	var bullet = preload("res://Scenes/Bullet.tscn")
	var bullet_instance = bullet.instance()
	print(get_angle_to(target))
	bullet_instance.rotation = get_angle_to(target)
	get_parent().add_child(bullet_instance)
	yield(get_tree().create_timer(rate_of_fire), "timeout")
	can_attack = true
	speed = 300
	