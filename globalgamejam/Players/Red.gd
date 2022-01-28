extends "res://character.gd"

const ACCELERATION = 512
const MAX_SPEED = 64
const FRICTION = 0.25
const GRAVITY = 200
const JUMP_FORCE = 128
const AIR_RESISTANCE = 0.04

const char_name = "RED"

export var level = 0
export var health = 3

func _ready():
	camera_pos(level)

func _physics_process(delta):
	
	physics(delta, char_name, ACCELERATION, MAX_SPEED, FRICTION, GRAVITY, JUMP_FORCE, AIR_RESISTANCE)
