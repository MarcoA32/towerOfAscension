extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -400.0

@onready var animated_sprite = $animated_sprite


func _physics_process(delta: float) -> void:
	# Add the gravity.

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction:
		velocity.x = direction.x * SPEED
		velocity.y = direction.y * SPEED
		update_animation(direction)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
		animated_sprite.stop()

	move_and_slide()
	
func update_animation(direction: Vector2) -> void:
	# Determine the animation based on direction vector
	if direction.x < 0:
			animated_sprite.play("left")
	elif direction.x > 0:
			animated_sprite.play("right")
	else:
		if direction.y < 0:
			animated_sprite.play("up")
		elif direction.y > 0:
			animated_sprite.play("down")
