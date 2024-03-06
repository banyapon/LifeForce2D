extends Area2D

@export var speed = 500
@export var bullet_direct = 1

func _ready():
	bullet_direct = Global.direction
	pass


func _physics_process(delta):
	global_position.x += speed * delta  * bullet_direct
	pass


func _on_body_entered(body):
	if body == get_tree().get_first_node_in_group("Enemy"):
		queue_free()
	pass # Replace with function body.


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	pass # Replace with function body.


func _on_area_entered(area):
	if area == get_tree().get_first_node_in_group("Enemy"):
		queue_free()
	pass # Replace with function body.
