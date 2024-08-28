extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -400.0

@onready var animated_sprite = $animated_sprite
var currentHealth: int 
var maxHealth: int = 100


func _ready() -> void:
	currentHealth = maxHealth
	var enemies = get_tree().get_nodes_in_group("Enemies")
	for enemy in enemies:
		print("Enemy:", enemy.name)
	

func _physics_process(delta: float) -> void:
	
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
			
func take_damage(amount: int):
	currentHealth -= amount
	print_debug(currentHealth)
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemies"):  # Assuming the player is in the "Player" group
		print("Player entered Detection Area")


func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemies"):  # Assuming the player is in the "Player" group
		print("Player entered Detection Area")
