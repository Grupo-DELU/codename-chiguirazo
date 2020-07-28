extends Area2D

export(float) var lifetime : float = 0.2
var damage: float

var damaged_bodies :Array = []   #for the spawned area to damage each enemy only once

func _ready():
	despawn()

func Hurt(body: Node2D) -> void:  #respuest a señal cuando el Area2D detecta cuerpos
	
	
	for entity in get_overlapping_bodies():
		
		if entity.has_method("Enem_take_damage"):
			if not entity in damaged_bodies:
				entity.Enem_take_damage(damage)
				damaged_bodies.append(entity)
				

func despawn() -> void:
	yield(get_tree().create_timer(lifetime),"timeout")
	queue_free()
