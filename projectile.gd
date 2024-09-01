extends CharacterBody2D

var velocityProj = Vector2(0,0)
var speed = 300
@onready var animated_sprite = $AnimatedSprite2D
var collision = false
@onready var timer = $Timer
func _physics_process(delta: float) -> void:
	
	var collision_info = move_and_collide(velocityProj.normalized()* delta * speed)
	if !collision:
		animated_sprite.play("projectile")
	if collision_info:
		print("its colliding")
		collision = true
		animated_sprite.play("splash")  # Assuming "collision" is the name of your collision animation
	# Optionally, you may want to stop the projectile from moving
		velocityProj = Vector2.ZERO
		timer.start()
		
		


func _on_timer_timeout() -> void:
	queue_free() # Replace with function body.
