class_name levels
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
var sceneTree = null
var level_counter = 0

# CLASS CONSTRUCTOR
func _init(tree = null):
	sceneTree = tree

# DELETES ALL ACTIVES INSTANCES
func clear_all():
	if purpleInstance != null:
		purpleInstance.queue_free()
	if redInstance != null:
		redInstance.queue_free()
	if currentMap != null:
		currentMap.queue_free()
	print("Clear successful!")

# TUTORIAL LEVEL - 0
func level0(): 
	# SETTING THE MAPS FOR THIS LEVEL
	levelMap_P = purpleMaps[0]
	levelMap_R = redMaps[0]
	
	currentMap = levelMap_P.instance()
	sceneTree.get_root().call_deferred("add_child", currentMap) #adds the level
	
	
	# SETTING UP THE PURPLE CHARACTER
	purpleInstance = purpleChar.instance()
	sceneTree.get_root().call_deferred("add_child", purpleInstance) #adding the purple character to the tree
	purpleInstance.position = Vector2(128,64) #setting a position THIS NEEDS TO BE CHANGED LATER BROOOOO
	purpleInstance.level = 0  #setting which level it is so that the instance knows (for camera work later)
	
# LEVEL 1
func level1():
	print("ass")
	
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

# WIN CONDITION, SWAP TO NEXT LEVEL
func _on_Door_level_complete():
	print("level complete signal received")
	level_counter += 1
	
	match level_counter:
		1: 
			level1()
		# make fade to black animation
