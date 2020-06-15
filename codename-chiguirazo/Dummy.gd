extends KinematicBody2D

const MAX_FORCE = 10
const WANDER_RING_DISTANCE = 150
const WANDER_RING_RADIUS = 50
const WIDTH = 1024
const HEIGHT = 600

var rng = RandomNumberGenerator.new()

var max_speed: int = 50
var velocity_direction 
var acceleration: Vector2 
var desired_velocity: Vector2
var steer: Vector2
var target: Vector2

func _ready():
	velocity_direction = Vector2(max_speed,0)
	acceleration = Vector2.ZERO
	target = Vector2(rng.randf_range(0,WIDTH),rng.randf_range(0,HEIGHT))
	
func _physics_process(delta):
	#acceleration = seek(get_global_mouse_position())
	acceleration = wander()
	#print(acceleration)
	velocity_direction += acceleration
	if velocity_direction.length() > max_speed:
		velocity_direction = velocity_direction.normalized() * max_speed
	print(velocity_direction)
	move_and_slide(velocity_direction)
	if position.x > WIDTH:
		 position.x = 0
	if position.x < 0:
		position.x = WIDTH
	if position.y > HEIGHT:
		position.y = 0
	if position.y < 0:
		position.y = HEIGHT



func seek(target: Vector2) -> Vector2:
	desired_velocity = (target - position).normalized() * max_speed
	steer = desired_velocity - velocity_direction
	steer = steer.clamped(MAX_FORCE)
	return steer

func wander() -> Vector2:
	var future = position + (velocity_direction.normalized() * WANDER_RING_DISTANCE)
	var target = future + Vector2(WANDER_RING_RADIUS,0).rotated(rng.randf_range(0,2 * PI))
	print(future)
	return seek(target)
	


