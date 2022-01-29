extends Area2D
var player_detected = false
var win_condition
signal level_complete

export var state = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("closed")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	_game_condition(state)
	
	if Input.is_action_pressed("interact"): #if the E key is pressed or right click
		if player_detected == true and win_condition == true: #check if there is also a collision
			print("door")
			$AnimatedSprite.play("open") #light the torch
			#$AudioStreamPlayer.play()
			emit_signal("level_complete")
			print("level complete signal emitted")
			player_detected = false
			
	print(state)
			

func _on_Door_body_entered(_body):
	player_detected = true

func _on_Door_body_exited(_body):
	player_detected = false

func _game_condition(state):
	
	if state == false:
		
		win_condition = false
		
	elif state == true:
		
		win_condition = true
	
