class_name Main
extends Node


onready var purpleChar = preload("res://Purple.tscn")
onready var redChar = preload("res://Red.tscn")
onready var purpleWorld = $PurpleDimension/Level1
onready var redWorld = $RedDimension/Level1
var purpleInstance
var redInstance

#var redInstance = redChar.instance()

# Called when the node enters the scene tree for the first time.
func _ready():
	_level0()
	

func _switch():
	pass
	
func _level0():
	
	#adding purple
	purpleInstance = purpleChar.instance() 
	add_child(purpleInstance) 
	
	purpleInstance.position = $StartPosition.position #sets the purple's position to the start position
	
	redWorld.visible = false
	
# Code inside block will be updated every frame
func _process(delta):
	
	var x_input = Input.is_action_just_pressed("dim_swap_key")
	
	if x_input != false:
		
		end_world()
		
		
func end_world():
	
	var groupSizeRED = get_tree().get_nodes_in_group("red").size()
	var groupSizePURPLE = get_tree().get_nodes_in_group("purple").size()
	
	print("in purple there are: " + str(groupSizePURPLE))
	print("in red there are: " + str(groupSizeRED))
	
	
	if groupSizeRED == 0:
	
		redInstance = redChar.instance() 
		add_child(redInstance) #adds the red guy
		redInstance.position = purpleInstance.position
		
		purpleInstance.queue_free() #deletes the purple guy
		
		redWorld.visible = true #sets visibility for the worlds
		purpleWorld.visible = false

		
	else:
		
		purpleInstance = purpleChar.instance() #adds the purple guy
		add_child(purpleInstance)
		purpleInstance.position = redInstance.position
		
		redInstance.queue_free() #clears the red guy
		
		redWorld.visible = false #sets the visibility for the worlds
		purpleWorld.visible = true
	
	
#	if redChar.visible == false:
#
#		redWorld.visible = true
#		redChar.visible = true
#		purpleChar.visible = false
#		purpleWorld.visible = false
#
#	else: 
#
#		redChar.visible = false
#		purpleChar.visible = true
#		purpleWorld.visible = true
#		redWorld.visible = false
