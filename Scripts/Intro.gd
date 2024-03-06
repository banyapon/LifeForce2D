extends Node2D

var message =[
	"THIS IS A PROJECT PROMETHEUS: ",
	"DESIGNED TO ADVANCE HUMAN EVOLUTION, INSTEAD IT UNLEASHED HELL.",
	"FROM THE DEPTHS OF THE BIOHAZARD LABS, THEY EMERGED. ",
	"UNNATURAL. ",
	"UNSTOPPABLE. LIFEFORCE IS HUMANITY'S LAST STAND.",
	"COMMAND, THIS IS GHOSTRIDER. PACKAGE COMPROMISED. HOSTILES OVERRUN THE LAB. ",
	"I'M GOING IN HOT - NEED BACKUP ASAP!"
]

var typing_speed = 0.1
var read_time = 0.5
var current_message = 0
var display = ""
var current_char = 0

func _ready():
	start_dialogue()
	pass 

func _process(delta):
	if Input.is_key_pressed(KEY_ENTER):
		await get_tree().create_timer(0.2).timeout
		get_tree().change_scene_to_file("res://Scenes/level_1.tscn")
	pass

func start_dialogue():
	current_message = 0
	display = ""
	current_char = 0
	
	$next_char.set_wait_time(typing_speed)
	$next_char.start()
	pass
	
func stop_dialogue():
	await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_file("res://Scenes/level_1.tscn")
	pass


func _on_next_char_timeout():
	if (current_char < len(message[current_message])):
		var next_char = message[current_message][current_char]
		display += next_char
		$Panel/Label.text = display
		current_char += 1
	else:
		$next_char.stop()
		$next_message.one_shot = true
		$next_message.set_wait_time(read_time)
		$next_message.start()
	pass

func _on_next_message_timeout():
	if (current_message == len(message) - 1):
		stop_dialogue()
	else:
		current_message += 1
		display = ""
		current_char = 0
		$next_char.start()
	pass 








