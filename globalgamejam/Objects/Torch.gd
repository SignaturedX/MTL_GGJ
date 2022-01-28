extends Area2D
var object = false
signal torch_on

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("unlit") #torch begins unlit

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_pressed("interact"): #if the E key is pressed or right click
		if object == true: #check if there is also a collision
			$AnimatedSprite.play("lit") #light the torch
			object = false
			emit_signal("torch_on")
			print("torch signal emitted")

func _on_Torch_body_entered(_body):
	object = true

func _on_Torch_body_exited(_body):
	object = false
