extends Area2D

var p_speed: int = 400  #Velocidad del proyetil
var damage: float 			#Daño del proyectil

func _process(delta: float) -> void:
		var v_direction: Vector2 = Vector2(1,0).rotated(rotation)  #Calcula la direccion
		position += v_direction * delta * p_speed

func _on_Bullet_body_entered(body: Node2D):
	for entity in get_overlapping_bodies():
		if entity.has_method("Player_take_damage"):
			entity.Player_take_damage(damage)
	queue_free()
