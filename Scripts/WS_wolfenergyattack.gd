extends "res://Scripts/BS_base_skill.gd"

var Attack :Node2D = null
export(float) var energy_attack_modifier :float = 1.0 #flat value that increases damage
											#this value is not affected by the buff, may increase with level

func Use_skill():
	Skill_used_signal()
	if Attack == null: 
		Attack = player.Attack
	
	Attack.Basic_attack(Attack.damage + energy_attack_modifier)
	
	.Use_skill()
