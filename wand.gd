extends CharacterBody2D
var is_shooting = false
var charging = false
@onready var shoot_cooldown_timer = $shootCooldown
@onready var charge_timer = $charge
@onready var animated_sprite = $AnimatedSprite2D
const projectilePath = preload('res://Projectile.tscn')
@onready var marker = $Node2D/Marker2D
var preMouse = get_global_mouse_position()

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_leftclick"):
		if is_shooting:
			pass
		else:
			shoot()
	
	
	
func shoot():
	is_shooting = true
	preMouse = get_global_mouse_position()
	animated_sprite.play("charge")
	charge_timer.start()
	
func _on_charge_timeout() -> void:
	var projectile =  projectilePath.instantiate()
	get_parent().add_child(projectile)
	projectile.global_position = marker.global_position
	projectile.look_at(preMouse)
	projectile.velocityProj = preMouse-projectile.global_position 
	charging = false # Replace with function body.
	shoot_cooldown_timer.start()

func _on_shoot_cooldown_timeout() -> void:
	is_shooting = false
