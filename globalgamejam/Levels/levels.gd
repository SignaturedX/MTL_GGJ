#class_name levels
extends Node
# warning-ignore:unused_signal
var purpleChar = preload("res://Players/Purple.tscn")
var redChar = preload("res://Players/Red.tscn")
var purpleInstance
var redInstance
var purpleMaps = [load("res://Levels/Level0_P.tscn"), load("res://Levels/Level1_P.tscn")]
var redMaps = [load("res://Levels/Level0_R.tscn"), load("res://Levels/Level1_R.tscn")]
var groupSizeRED
var groupSizePURPLE
var levelMap_R
var levelMap_P
var currentMap
onready var sceneTree = get_tree()
var level_counter = 0
var animation_finished = false
var door
var torch


# DELETES ALL ACTIVES INSTANCES
func clear_all():
	if purpleInstance != null:
		purpleInstance.queue_free()
	if redInstance != null:
		redInstance.queue_free()
	if currentMap != null:
		currentMap.queue_free()
	print("Clear successful!")

func _ready():
	level0()
	door = currentMap.get_node("Door")
	door.connect("level_complete", self, "_on_Door_level_complete")
	
func _process(delta):
	
	var x_input = Input.is_action_just_pressed("dim_swap_key")

	if x_input != false:

		end_world() 


# TUTORIAL LEVEL - 0
func level0(): 
	# SETTING THE MAPS FOR THIS LEVEL
	levelMap_P = purpleMaps[0]
	levelMap_R = redMaps[0]
	
	currentMap = levelMap_P.instance()
	sceneTree.get_root().call_deferred("add_child", currentMap) #adds the level
	print("connected")


	# SETTING UP THE PURPLE CHARACTER
	purpleInstance = purpleChar.instance()
	sceneTree.get_root().call_deferred("add_child", purpleInstance) #adding the purple character to the tree
	purpleInstance.position = Vector2(128,64) #setting a position THIS NEEDS TO BE CHANGED LATER BROOOOO
	purpleInstance.level = 0  #setting which level it is so that the instance knows (for camera work later)
	
# LEVEL 1
func level1(level_num):
	setup(level_num)
	
	
func setup(level_num):
	levelMap_P = purpleMaps[level_num]
	levelMap_R = redMaps[level_num]
	
	currentMap = levelMap_P.instance()
	sceneTree.get_root().add_child(currentMap) #adds the level
	
	
	# SETTING UP THE PURPLE CHARACTER
	purpleInstance = purpleChar.instance()
	sceneTree.get_root().add_child(purpleInstance) #adding the purple character to the tree
	purpleInstance.position = Vector2(128,64) #setting a position THIS NEEDS TO BE CHANGED LATER BROOOOO
	purpleInstance.level = level_num  #setting which level it is so that the instance knows (for camera work later)
	
# SWITCHING BETWEEN DIMENSIONS
func end_world():
	
	groupSizeRED = sceneTree.get_nodes_in_group("red").size()
	
	# SWAP TO RED
	if groupSizeRED == 0: 
		# CHANGING MAP
		currentMap.queue_free()
		currentMap = levelMap_R.instance()
		sceneTree.get_root().add_child(currentMap)
		
		# CHANGING CHARACTER
		redInstance = redChar.instance()
		sceneTree.get_root().add_child(redInstance)
		redInstance.position = purpleInstance.position
		purpleInstance.queue_free() #clears the purple guy
		door = currentMap.get_node("Door")
		door.connect("level_complete", self, "_on_Door_level_complete")
		
	# SWAP TO PURPLE
	else: 
		
		# CHANGING MAP
		currentMap.queue_free()
		currentMap = levelMap_P.instance()
		sceneTree.get_root().add_child(currentMap)
		
		# CHANGING CHARACTER
		purpleInstance = purpleChar.instance()
		sceneTree.get_root().add_child(purpleInstance)
		purpleInstance.position = redInstance.position
		redInstance.queue_free() #clears the red guy
		door = currentMap.get_node("Door")
		door.connect("level_complete", self, "_on_Door_level_complete")

# WIN CONDITION, SWAP TO NEXT LEVEL
func _on_Door_level_complete():
	
	if sceneTree.get_nodes_in_group("red").size() == 1:
		
		currentMap.queue_free()
		redInstance.queue_free()
	
	else:
		
		currentMap.queue_free()
		purpleInstance.queue_free()
		
		
	print("level complete signal received")
	level_counter += 1
	print(sceneTree)
	print("red" + str(sceneTree.get_nodes_in_group("red").size()))
	print("purple" + str(sceneTree.get_nodes_in_group("purple").size()))
	print("levels" + str(sceneTree.get_nodes_in_group("levels").size()))

	match level_counter:
		1:
			level1(1)
