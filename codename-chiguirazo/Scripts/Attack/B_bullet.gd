extends Area2D

var p_speed: int = 400  #Velocidad del proyetil
var damage 			#Daño del proyectil


func _process(delta: float) -> void:
		var v_direction: Vector2 = Vector2(1,0).rotated(rotation)  #Calcula la direccion
		global_position += v_direction * delta * p_speed

func _on_Bullet_body_entered(body):
	queue_free()
