extends Area2D
var player_detected = false
var win_condition = false
signal level_complete

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("closed")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_pressed("interact"): #if the E key is pressed or right click
		if player_detected == true and win_condition == true: #check if there is also a collision
			print("door")
			$AnimatedSprite.play("open") #light the torch
			#$AudioStreamPlayer.play()
			emit_signal("level_complete")
			print("level complete signal emitted")
			player_detected = false
			

func _on_Door_body_entered(_body):
	player_detected = true

func _on_Door_body_exited(_body):
	player_detected = false

func _on_Torch_torch_on():
	print("torch signal received")
	win_condition = true
