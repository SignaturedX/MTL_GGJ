class_name Main
extends Node


onready var purpleChar = preload("res://Purple.tscn")
onready var redChar = preload("res://Red.tscn")
onready var purpleWorld = $PurpleDimension/Level1
onready var redWorld = $RedDimension/Level1

var purpleInstance = purpleChar.instantiate() #sets up the instance 
var redInstance = redChar.instantiate()

# Called when the node enters the scene tree for the first time.
func _ready():
	_level0()
	

func _switch():
	pass
	
func _level0():
	
	add_child(purpleInstance) #adds the instance to the scene (purple)
	
	add_child(redInstance)
	
	#setting start positions for each character at the start of the level
	
	purpleInstance.position = $PurpleDimension/StartPosition.position
	
	redInstance.position = $RedDimension/StartPosition.position
	redInstance.visible = false
	
# Code inside block will be updated every frame
func _process(delta):
	
	var x_input = Input.is_action_just_pressed("dim_swap_key")
	
	if x_input != false:
		
		end_world()
		
		
func end_world():
	
	if redChar.visible == false:
	
		redWorld.visible = true
		redChar.visible = true
		purpleChar.visible = false
		purpleWorld.visible = false
		
	else:
		
		redChar.visible = false
		purpleChar.visible = true
		purpleWorld.visible = true
		redWorld.visible = false
