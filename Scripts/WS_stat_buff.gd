extends "res://Scripts/BS_base_skill.gd"

var m_buff : float= 1.5 #Fuerza del buff (skill)

#Nodes
onready var Buff_duration: Timer = $"BDuration"
signal b_finished

func _ready():
	is_prolongated = true

func Use_skill() -> void: #L1: BUFF
	
	Skill_used_signal()
	
	can_use = false
	
	 #La skill es un buff a estas 3 stats
	var w_damage = player.damage
	var w_defense = player.defense
	var w_speed = player.max_speed
	player.buffed = true
	
	player.Damage_change(w_damage * m_buff)
	player.Defense_change(w_defense * m_buff)
	player.Speed_change(w_speed * m_buff)
	
	Buff_duration.start()
	yield(Buff_duration,"timeout")  #El buff es temporal (se deshace luegode un tiempo)
	
	player.Damage_change(w_damage)
	player.Defense_change(w_defense)
	player.Speed_change(w_speed)
	emit_signal("b_finished")
	player.buffed = false
	
	.Use_skill()  # espera al cooldown para poder usar la skill de nuevo

