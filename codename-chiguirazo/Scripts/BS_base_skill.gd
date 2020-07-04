extends Node2D

class_name base_skill

#Limiting skill use
var cooldown :float = 1.5
var can_use :bool = true

#Skill properties
var is_prolongated :bool = false

#Nodes
onready var STimer :Timer= get_node("SkillTimer")
onready var Manager :Node = get_parent()

func _ready() -> void:
	STimer.wait_time = cooldown

func Use_skill() -> void:
	STimer.start()

func _on_SkillTimer_timeout():
	can_use = true
