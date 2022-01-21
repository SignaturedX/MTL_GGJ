class_name character
extends KinematicBody2D

var motion = Vector2.ZERO

onready var sprite = $AnimatedSprite
onready var world = Main.new()

func physics(dif = 0.01, type = "NONE", accel = 512, msp = 64, fric = 0.25, grav = 200, jf = 128, ar = 0.04):
	
		var x_input = Input.get_action_strength("right_key") - Input.get_action_strength("left_key")
		
		if x_input != 0: # If the player is moving
			
			sprite.play("move") # Plays the move animation
			
			motion.x += x_input * accel * dif
			
			motion.x = clamp(motion.x, -msp, msp)
			
			sprite.flip_h = x_input < 0
			
		else: # If player is not moving
			
			# sprite.stop() # Stops the animation, yet continues last frame of "move" animation
			
			if is_on_floor(): # If the player is on the floor, play the "idle" animation
				
				sprite.play("idle")
			
		motion.y += grav * dif

		if is_on_floor():
			
			if x_input == 0:
				
				motion.x = lerp(motion.x, 0, fric)
				
			if Input.is_action_just_pressed("up_key"):
				
				motion.y = -jf
		else: 
			
			if Input.is_action_just_released("up_key") and motion.y < -jf/2:
				
				motion.y = -jf/2
				
			if x_input == 0:
				
				motion.x = lerp(motion.x, 0, ar)
				
		motion = move_and_slide(motion, Vector2.UP)
		
