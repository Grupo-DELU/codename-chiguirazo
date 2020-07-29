extends "res://Scripts/BS_base_skill.gd"

var Attack :Node2D = null
export(float) var energy_attack_modifier :float = 1.0 #flat value that increases damage
											#this value is not affected by the buff, but does stack with it
											
func Use_skill():
	Skill_used_signal()
	if Attack == null: 
		Attack = player.Attack
	
	Attack.Basic_attack(Attack.damage + energy_attack_modifier)
	
	.Use_skill()
