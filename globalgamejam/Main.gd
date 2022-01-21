class_name Main
extends Node

onready var purpleChar = $Purple
onready var redChar = $Red
onready var purpleWorld = $PurpleDimension/Level1
onready var redWorld = $RedDimension/Level1

onready var red = get_tree().get_nodes_in_group("red")
onready var purple = get_tree().get_nodes_in_group("purple")

# Called when the node enters the scene tree for the first time.
func _ready():
	_level0()
	

func _switch():
	pass
	
func _level0():
	
	#setting start positions for each character at the start of the level
	
	purpleChar.position = $PurpleDimension/StartPosition.position
	
	redChar.position = $RedDimension/StartPosition.position
	redChar.visible = false
	
# Code inside block will be updated every frame
func _process(delta):
	
<<<<<<< Updated upstream
	var x_input = Input.is_action_just_pressed("dim_swap_key")
=======
<<<<<<< HEAD
=======
	var x_input = Input.is_action_just_pressed("dim_swap_key")
>>>>>>> 54d9f94810bfe094ffe7b33c4c1b4df438903b4b
>>>>>>> Stashed changes
	
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
