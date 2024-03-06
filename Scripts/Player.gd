extends CharacterBody2D

@export var speed = 300
@export var gravity = 20
@export var jump_force = 450

@onready var animationPlayer = $AnimationPlayer 
@onready var sprite2D = $Sprite2D
@onready var collisionShape2D = $CollisionShape2D
@onready var markLeft = $MarkLeft
@onready var markRight = $MarkRight
@onready var area2DCollision = $Area2D/CollisionShape2D

var moving_speed = 0
var collider_standing = preload("res://Resources/Collider_Standing.tres")
var collider_crunch = preload("res://Resources/Collider_Crunch.tres")

var bullet_prefabs = preload("res://Prefabs/bullet.tscn")

var shooting := false
var isCrunch : bool = false
var isJump := false
var isAimHigh := false


var isDeath := false

func _ready():
	moving_speed = speed
	pass


func _process(delta):
	if Input.is_key_pressed(KEY_P):
		if !shooting:
			if !isDeath:
				shooting = true
				fire()
				await get_tree().create_timer(0.2).timeout
				shooting = false
	
	pass

func _physics_process(delta):
	if !is_on_floor():
		velocity.y += gravity
		if velocity.y > 2000:
			velocity.y = 2000
			
	if Input.is_action_just_pressed("ui_accept"):
		if !isJump:
			isJump = true
			velocity.y = -jump_force
			await get_tree().create_timer(0.5).timeout
			isJump = false
		
	if Input.is_action_just_pressed("ui_down"):
		isCrunch = true
		moving_speed = 0
		
	if Input.is_action_just_released("ui_down"):
		moving_speed = speed
		isCrunch = false
	
	if Input.is_action_pressed("ui_up"):
		isAimHigh = true
	elif Input.is_action_just_released("ui_up"):
		isAimHigh = false
		
	var horizontal_direction = Input.get_axis("ui_left", "ui_right")
	velocity.x = moving_speed * horizontal_direction
	
	if horizontal_direction < 0:
		Global.direction = -1
	elif horizontal_direction > 0:
		Global.direction = 1
		
	if horizontal_direction != 0:
		sprite2D.flip_h = (horizontal_direction == -1)
	
	move_and_slide()
	change_animations(horizontal_direction)
	
	if isAimHigh:
		markRight.rotate(deg_to_rad(-45))
		markLeft.rotate(deg_to_rad(-45))
	else:
		markRight.rotate(0)
		markLeft.rotate(0)
	
	pass

func change_animations(horizontal_direction):
	
		
	if is_on_floor():
		if horizontal_direction == 0:
			animationPlayer.play("Idle")
		else:
			if isAimHigh:
				animationPlayer.play("RunUp")
			else:
				animationPlayer.play("Run")
	else:
		if velocity.y < 0:
			animationPlayer.play("Jump")
		elif velocity.y >0:
			animationPlayer.play("Jump")
	
	if isCrunch:
		animationPlayer.play("Crunch")
		collisionShape2D.shape = collider_crunch
	
	if isDeath:
		animationPlayer.play("Die")
		area2DCollision.disabled = true
		moving_speed = 0
		jump_force = 0
		await get_tree().create_timer(0.6).timeout
		get_tree().reload_current_scene()
	pass

func fire():
	var bullet = bullet_prefabs.instantiate()
	if Global.direction < 0:
		bullet.global_position = markLeft.global_position
	elif Global.direction > 0:
		bullet.global_position = markRight.global_position
	get_parent().add_child(bullet)
	pass


func _on_area_2d_body_entered(body):
	if body == get_tree().get_first_node_in_group("Enemy"):
		isDeath = true
	pass # Replace with function body.
