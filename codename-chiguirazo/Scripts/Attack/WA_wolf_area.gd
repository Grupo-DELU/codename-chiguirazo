extends Area2D

export(float) var lifetime = 0.2
var damage

func _ready():
	despawn()

func Hurt(body: Node2D) -> void:  #respuest a señal cuando el Area2D detecta cuerpos
	for entity in get_overlapping_bodies():
		if entity.has_method("Enem_take_damage"):
			entity.Enem_take_damage(damage)

func despawn() -> void:
	yield(get_tree().create_timer(lifetime),"timeout")
	queue_free()
