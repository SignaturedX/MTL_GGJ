extends "res://character.gd"

const ACCELERATION = 512
const MAX_SPEED = 80
const FRICTION = 1
const GRAVITY = 400
const JUMP_FORCE = 128
const AIR_RESISTANCE = 0.02

const char_name = "PURPLE"
export var level = 0
export var health = 3

func _ready():
	
	pass

func _physics_process(delta):
	
	physics(delta, char_name, ACCELERATION, MAX_SPEED, FRICTION, GRAVITY, JUMP_FORCE, AIR_RESISTANCE)
	camera_pos(level)
	
func levelInc():
	
	level += 1
