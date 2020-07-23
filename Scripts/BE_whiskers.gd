extends Node2D

func _ready():
	for w in get_children():
		w.add_exception(get_parent().get_parent())
	pass
