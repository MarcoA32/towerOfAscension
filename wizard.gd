extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -400.0
@onready var animated_sprite = $animated_sprite
var currentHealth: int 
var maxHealth: int = 100
const projectilePath = preload('res://Projectile.tscn')
var left = false
var right = false
var down = true 
var up = false
var is_shooting = false
var animation = false
var charging = false

func _ready() -> void:
	currentHealth = maxHealth
	$Label.text = str(currentHealth) + "hp"
	var _enemies = get_tree().get_nodes_in_group("Enemies")
	

func _physics_process(_delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction:
		velocity.x = direction.x * SPEED
		velocity.y = direction.y * SPEED
		if animation == false: 
			update_animation(direction)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
		if animation == false:
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
			
func take_damage(attack: int):
	currentHealth -= attack
	$Label.text = str(currentHealth) + "hp"
	if self.currentHealth <=0:
		queue_free()
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemies"):  # Assuming the player is in the "Player" group
		print("Player entered Detection Area")

func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemies"): 
		take_damage(5)

	
