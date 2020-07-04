extends "res://Scripts/BS_base_skill.gd"

var m_buff : float= 1.5 #Fuerza del buff (skill)

#Nodes
onready var Buff_duration: Timer = $"BDuration"
signal b_finished

func _ready():
	is_prolongated = true

func Use_skill() -> void: #L1: BUFF
	
	var wolfie :KinematicBody2D = Manager.Player #El jugador
	
	wolfie.emit_signal("skill_used",wolfie)
	can_use = false
	
	 #La skill es un buff a estas 3 stats
	var w_damage = wolfie.damage
	var w_defense = wolfie.defense
	var w_speed = wolfie.max_speed
	wolfie.buffed = true
	
	wolfie.Damage_change(w_damage * m_buff)
	wolfie.Defense_change(w_defense * m_buff)
	wolfie.Speed_change(w_speed * m_buff)
	
	Buff_duration.start()
	yield(Buff_duration,"timeout")  #El buff es temporal (se deshace luegode un tiempo)
	
	wolfie.Damage_change(w_damage)
	wolfie.Defense_change(w_defense)
	wolfie.Speed_change(w_speed)
	emit_signal("b_finished")
	wolfie.buffed = false
	
	.Use_skill()  # espera al cooldown para poder usar la skill de nuevo

