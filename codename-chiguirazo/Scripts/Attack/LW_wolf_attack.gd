extends pl_attack

var slash :PackedScene = preload("res://Scenes/Wolf_Attack.tscn") #ataque del lobo
var m_buff : float= 1.5 #Fuerza del buff (skill)
var b_duration :float= 5.0  #duración del buff
var s_range :float= 50.0 #rango del salsh (ataque) del lobo

signal b_finished

func Basic_attack() -> void: #Slash (AOE)
	c_attack = false
	$Spawner.position = get_local_mouse_position().normalized()*s_range
	var i_slash = Spawn(slash)
	i_slash.damage = damage
	i_slash.position -= get_global_position()
	i_slash.rotation = get_local_mouse_position().angle()
	#main_scene.
	add_child(i_slash)
	
	.Basic_attack() #esto es una supercall, ejecuta la función como está declarada en la clase base
	
func Use_skill() -> void: #L1: BUFF
	c_skill = false
	
	var wolfie = get_parent()   #La skill es un buff a estas 3 stats
	wolfie.buffed = true
	wolfie.damage *= m_buff
	wolfie.speed *= m_buff
	wolfie.defense *= m_buff
	
	yield(get_tree().create_timer(b_duration),"timeout")  #El buff es temporal (se deshace luegode un tiempo)
	wolfie.damage /= m_buff
	wolfie.speed /= m_buff
	wolfie.defense /= m_buff
	emit_signal("b_finished")
	wolfie.buffed = false
	
	.Use_skill()  # espera al cooldown para poder usar la skill de nuevo