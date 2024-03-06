extends Node2D

@export var isSpawn := false
var enemy_prefab  = preload("res://Scenes/enemy.tscn")

func _ready():
	set_process(true)
	pass

func _process(delta):
	if !isSpawn:
		isSpawn = true
		var timer_count = randf_range(1.0,5.0)
		await get_tree().create_timer(timer_count).timeout
		spawning_enemy()
		isSpawn = false
	pass

func spawning_enemy():
	var enemy_instance = enemy_prefab.instantiate()
	var spawn_position = get_random_position()
	enemy_instance.global_position = spawn_position
	get_parent().add_child(enemy_instance)
	pass

func get_random_position():
	var screen_size = get_viewport_rect().size
	var random_position = Vector2(randf_range(0,screen_size.x),randf_range(0,0.2))
	return random_position





