extends RigidBody2D

var projectile_speed = 400
var damage


func _ready() -> void:
	apply_impulse(Vector2(), Vector2(projectile_speed, 0).rotated(rotation))
	yield(get_tree().create_timer(5),"timeout")
	queue_free()

