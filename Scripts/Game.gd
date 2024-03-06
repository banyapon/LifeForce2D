extends Node2D

@onready var spawnPoint = $SpawnPoint
var player = null

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	assert(player!=null)
	player.global_position = spawnPoint.global_position
	pass 


func _process(delta):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
	if Input.is_key_pressed(KEY_R):
		get_tree().reload_current_scene()
	pass
