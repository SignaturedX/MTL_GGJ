extends Area2D
var body_entered = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("unlit") #torch begins unlit

#Activated when any other body collides with the torch
func _on_Torch_body_entered(body):
	body_entered = true 
	
#Updates every frame
func _process(delta):
	if Input.is_action_pressed("interact"): #if the interact key is pressed
		if body_entered == true: #check if there is also a collision
			$AnimatedSprite.play("lit") #light the torch
