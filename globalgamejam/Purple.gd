extends "res://character.gd"

const ACCELERATION = 512
const MAX_SPEED = 64
const FRICTION = 0.25
const GRAVITY = 200
const JUMP_FORCE = 128
const AIR_RESISTANCE = 0.04

const char_name = "PURPLE"

func _physics_process(delta):
	
<<<<<<< Updated upstream
	physics(delta, char_name, ACCELERATION, MAX_SPEED, FRICTION, GRAVITY, JUMP_FORCE, AIR_RESISTANCE)
=======
<<<<<<< HEAD
	var x_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if x_input != 0: # If the player is moving
		
		sprite.play("move") # Plays the move animation
		
		motion.x += x_input * ACCELERATION * delta
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
		
		sprite.flip_h = x_input < 0
		
	else: # If player is not moving
		
		sprite.stop() # stops the animation, yet continues last frame of "move" animation
		
		if is_on_floor(): # If the player is on the floor, play the "idle" animation
			
			sprite.play("idle")
		
	motion.y += GRAVITY * delta

	if is_on_floor():
		
		if x_input == 0:
			
			motion.x = lerp(motion.x, 0, FRICTION)
			
		if Input.is_action_just_pressed("ui_up"):
			
			motion.y = -JUMP_FORCE
	else: 
		
		if Input.is_action_just_released("ui_up") and motion.y < -JUMP_FORCE/2:
			
			motion.y = -JUMP_FORCE/2
			
		if x_input == 0:
			
			motion.x = lerp(motion.x, 0, AIR_RESISTANCE)
			
	motion = move_and_slide(motion, Vector2.UP)

#HELLO THERE THIS IS A CHANGE
#HELLO THERE THIS IS A CHANGE
=======
	physics(delta, char_name, ACCELERATION, MAX_SPEED, FRICTION, GRAVITY, JUMP_FORCE, AIR_RESISTANCE)
>>>>>>> 54d9f94810bfe094ffe7b33c4c1b4df438903b4b
>>>>>>> Stashed changes
