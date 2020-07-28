extends "res://Scripts/BS_base_skill.gd"

var Attack :Node2D = null
export(float) var energy_attack_damage :float = 3.0

func Use_skill():
	Skill_used_signal()
	if Attack == null: 
		Attack = player.Attack
	
	Attack.Basic_attack(energy_attack_damage)
	
	.Use_skill()
