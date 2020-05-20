extends pl_attack

var slash = preload("res://Scenes/Wolf_Attack.tscn")
var buff_mult = 1.5
var buff_duration = 5
var slash_range = 50

signal buff_finished

func _Basic_attack(): #Slash (AOE)
	can_attack = false
	$Spawner.position = get_local_mouse_position().normalized()*slash_range
	var slash_i = Spawn_the(slash)
	slash_i.damage = damage
	._Basic_attack() #esto es una supercall, ejecuta la función como está declarada en la clase base
	
func _Use_skill(): #L1: BUFF
	can_skill = false
	
	var wolfie = get_parent()   #La skill es un buff a estas 3 stats
	wolfie.buffed = true
	wolfie.damage *= buff_mult
	wolfie.speed *= buff_mult
	wolfie.Defense *= buff_mult
	
	yield(get_tree().create_timer(buff_duration),"timeout")  #El buff es temporal (se deshace luegode un tiempo)
	wolfie.damage /= buff_mult
	wolfie.speed /= buff_mult
	wolfie.Defense /= buff_mult
	emit_signal("buff_finished")
	wolfie.buffed = false
	
	._Use_skill()  # espera al cooldown para poder usar la skill de nuevo