class_name character
extends KinematicBody2D

var motion = Vector2.ZERO

onready var sprite = $AnimatedSprite
onready var camera = $Camera2D

func camera_pos(level):
	var viewport = get_viewport().size
	match level:
		0:
			print("level 0 camera")
			camera.limit_top = 0
			camera.limit_left = 0
			camera.limit_right = viewport.x
			camera.limit_bottom = viewport.y
		1: 
			print("level 1 camera")
			camera.limit_top = 0
			camera.limit_left = 0
			camera.limit_right = 100000
			camera.limit_bottom = 100000
			
		
	


func physics(dif = 0.01, _type = "NONE", accel = 512, msp = 64, fric = 0.25, grav = 200, jf = 128, ar = 0.04):
	
		var x_input = Input.get_action_strength("right_key") - Input.get_action_strength("left_key")
		
		if x_input != 0: # If the player is moving
			
			if is_on_floor():
				if !$AudioStreamPlayer.playing:
					$AudioStreamPlayer.play()
			
			sprite.play("move2") # Plays the move animation
			
			motion.x += x_input * accel * dif
			
			motion.x = clamp(motion.x, -msp, msp)
			
			sprite.flip_h = x_input < 0
			
		else: # If player is not moving
			
			$AudioStreamPlayer.stop()
			
			# sprite.stop() # Stops the animation, yet continues last frame of "move" animation
			
			if is_on_floor(): # If the player is on the floor, play the "idle" animation
				
				sprite.play("idle2")
			
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
		
