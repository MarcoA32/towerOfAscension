extends Node2D

var location = Vector2()
@onready var spawnTime = $spawnTime
var spawning = false 

var packed_scene = [
	preload("res://gremlin.tscn")
]

func _process(_delta: float) -> void:
	if spawning:
		pass
	else:
		spawning = true
		spawnTime.start()


func _on_spawn_time_timeout() -> void:
	print("spawn")
	randomize()
	var x = randi() % packed_scene.size()
	location.x = randf_range(1, 216)
	location.y = randf_range(1, 140)
	var scene = packed_scene[x].instantiate()
	scene.position = location
	add_child(scene)
	spawning = false
