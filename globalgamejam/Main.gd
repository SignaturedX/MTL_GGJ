extends Node

onready var purpleChar = $Purple
onready var redChar = $Red
onready var purpleWorld = $PurpleDimension
onready var redWorld = $RedDimension

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
	
	
func _invisible(var array): #will take 
	pass
	
	
	
