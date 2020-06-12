extends attaku_base

class_name enem_attack

#Atributos
var speed :float = get_parent().speed
var bullet: PackedScene = preload("res://Scenes/Bullet.tscn")

var cooldown_course #Para resumir un yield antes de que la clase deje de existir
#Métodos
func Attack_check(): #Chequea si puede atacar
	pass


func Attack(target: Vector2):
	c_attack = false
	speed = 0
	#fire_direction = (get_angle_to(player_position)/3.14)*100
	var i_bullet = Spawn(bullet)
	i_bullet.position -= get_global_position()
	i_bullet.rotation = get_angle_to(target)
	i_bullet.damage = damage
	get_parent().add_child(i_bullet)
	
	##This might be a function later##
	Attack_timer.start()
	#yield(get_tree().create_timer(attack_cooldown), "timeout")
	
	#c_attack = true
	#speed = 300

func _on_ATimer_timeout():
	c_attack = true
	speed = 300
	
