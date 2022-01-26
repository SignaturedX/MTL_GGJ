extends "res://character.gd"

const ACCELERATION = 512
const MAX_SPEED = 80
const FRICTION = 0.25
const GRAVITY = 300
const JUMP_FORCE = 128
const AIR_RESISTANCE = 0.02

const char_name = "PURPLE"


func _physics_process(delta):
	
	physics(delta, char_name, ACCELERATION, MAX_SPEED, FRICTION, GRAVITY, JUMP_FORCE, AIR_RESISTANCE)
