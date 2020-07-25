extends pl_attack

var slash :PackedScene = preload("res://Scenes/Wolf_Attack.tscn") #ataque del lobo

var s_range :float= 50.0 #rango del salsh (ataque) del lobo



func Basic_attack(dmg) -> void: #Slash (AOE)
	$Spawner.position = get_local_mouse_position().normalized()*s_range
	var i_slash = Spawn(slash)
	i_slash.damage = dmg
	i_slash.position -= get_global_position()
	i_slash.rotation = get_local_mouse_position().angle()

	add_child(i_slash)
	
	.Basic_attack(dmg) #esto es una supercall, ejecuta la función como está declarada en la clase base
