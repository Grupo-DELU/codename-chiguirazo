extends pl_attack

var slash = preload("res://Scenes/Wolf_Attack.tscn")
var buff_mult = 1.5
var buff_duration = 5

func _Basic_attack():
	can_attack = false
	var slash_i = Spawn_the(slash)
	slash_i.damage = damage
	._Basic_attack() #esto es una supercall, ejecuta la función como está declarada en la clase base
	
func _Use_skill():
	can_skill = false
	
	var wolfie = get_parent()
	wolfie.damage *= buff_mult
	wolfie.speed *= buff_mult
	wolfie.Defense *= buff_mult
	
	yield(get_tree().create_timer(buff_duration),"timeout")
	wolfie.damage /= buff_mult
	wolfie.speed /= buff_mult
	wolfie.Defense /= buff_mult
	
	._Use_skill()