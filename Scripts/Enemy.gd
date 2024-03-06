extends CharacterBody2D

@export var speed = 20
var player_node = null 


@onready var area2DCollison = $Area2D/CollisionShape2D
@onready var animatedSprite2D = $AnimatedSprite2D
@onready var collisionshape2D = $CollisionShape2D

func _ready():
	player_node = get_tree().get_first_node_in_group("Player")
	pass


func _physics_process(delta):
	move_and_collide(Vector2(0,300))
	if player_node:
		var direction = (player_node.global_position - global_position).normalized()			
		if direction.x > 0:
			animatedSprite2D.set_flip_h(false)
		elif direction.x < 0:
			animatedSprite2D.set_flip_h(true)
		
		velocity = direction * speed
		move_and_slide()
	pass


func _on_area_2d_area_entered(area):
	if area == get_tree().get_first_node_in_group("Bullet"):
		animatedSprite2D.play("Death")
		speed = 0
		Global._getScore()
		area2DCollison.disabled = true
		collisionshape2D.disabled = true
		await get_tree().create_timer(0.5).timeout
		queue_free()
	pass 
	

