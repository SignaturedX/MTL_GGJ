#class_name levels
extends Node
# warning-ignore:unused_signal

var purpleChar = preload("res://Players/Purple.tscn")
var redChar = preload("res://Players/Red.tscn")
var purpleInstance
var redInstance
var purpleMaps = [load("res://Levels/Level0_P.tscn"), load("res://Levels/Level1_P.tscn"), load("res://Levels/Level2_P.tscn")]
var redMaps = [load("res://Levels/Level0_R.tscn"), load("res://Levels/Level1_R.tscn")]
var itemMaps = [load("res://Levels/Level0_items.tscn"), load("res://Levels/Level1_items.tscn")]
var loadOnce = []
var groupSizeRED
var groupSizePURPLE
var levelMap_R
var levelMap_P
var itemMap
var currentMap
var currentItemMap
onready var sceneTree = get_tree()
var level_counter = 0
var animation_finished = false
var door
var light = false
var torch
var heart
var totalHearts = 1
var dimension = "purple"

signal heartGain
signal heartsVisible
signal levelCam


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
	
	coreSignals()
	
	
	
func _process(delta):
	
	var x_input = Input.is_action_just_pressed("dim_swap_key")

	if x_input != false:

		end_world() 


# TUTORIAL LEVEL - 0
func level0(): 
	# SETTING THE MAPS FOR THIS LEVEL
	levelMap_P = purpleMaps[0]
	levelMap_R = redMaps[0]
	itemMap = itemMaps[0]
	
	currentMap = levelMap_P.instance()
	sceneTree.get_root().call_deferred("add_child", currentMap) #adds the level
	
	# ITEM MAP
	currentItemMap = itemMap.instance()
	sceneTree.get_root().call_deferred("add_child", currentItemMap) #adds the level
	

	# SETTING UP THE PURPLE CHARACTER
	purpleInstance = purpleChar.instance()
	sceneTree.get_root().call_deferred("add_child", purpleInstance) #adding the purple character to the tree
	purpleInstance.position = Vector2(128,64) #setting a position THIS NEEDS TO BE CHANGED LATER BROOOOO
	purpleInstance.level = 0  #setting which level it is so that the instance knows (for camera work later)
	
# LEVEL 1
func level1(level_num):
	setup(level_num)
	level_counter += 1
	
# LEVEL 2
func level2(level_num):
	
	level_counter += 1 #updating the level
	
	currentItemMap.queue_free()
	
	currentMap.queue_free()
	#ADDING THE MAP
	levelMap_P = purpleMaps[level_num]
	currentMap = levelMap_P.instance()
	sceneTree.get_root().add_child(currentMap)
	currentMap.set_collision_mask_bit(3, true) #set it so that the red character can also collide with floor
	

	# SETTING UP THE PURPLE CHARACTER
	purpleInstance = purpleChar.instance()
	sceneTree.get_root().add_child(purpleInstance) #adding the purple character to the tree
	purpleInstance.position = Vector2(32,96) # on left side of map
	purpleInstance.level = level_num  #setting which level it is so that the instance knows (for camera work later
	
	redInstance = redChar.instance()
	sceneTree.get_root().add_child(redInstance)
	redInstance.position = Vector2(352, 96) # on right side of map
	redInstance.level = level_num
	
	
# SETUP METHOD FOR ALL LEVELS (except 2)
func setup(level_num):
	levelMap_P = purpleMaps[level_num]
	levelMap_R = redMaps[level_num]
	itemMap = itemMaps[level_num]
	
	currentMap = levelMap_P.instance()
	sceneTree.get_root().add_child(currentMap) #adds the level
	
	currentItemMap.queue_free()
	currentItemMap = itemMap.instance()
	sceneTree.get_root().add_child(currentItemMap) #adds the level
	
	
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
		
		currentItemMap.raise()
		
		# CHANGING CHARACTER
		redInstance = redChar.instance()
		sceneTree.get_root().add_child(redInstance)
		redInstance.position = purpleInstance.position
		redInstance.level = level_counter
		purpleInstance.queue_free() #clears the purple guy
		
		dimension = "red"
		emit_signal("heartsVisible", dimension)
		
	# SWAP TO PURPLE
	else: 
		
		# CHANGING MAP
		currentMap.queue_free()
		currentMap = levelMap_P.instance()
		sceneTree.get_root().add_child(currentMap)
		
		currentItemMap.raise()
		
		# CHANGING CHARACTER
		purpleInstance = purpleChar.instance()
		sceneTree.get_root().add_child(purpleInstance)
		purpleInstance.position = redInstance.position
		purpleInstance.level = level_counter
		redInstance.queue_free() #clears the red guy
		
		dimension = "purple"
		emit_signal("heartsVisible", dimension)
		
	coreSignals()
	

		
# ON TORCH LIGHT -- > SAVE TORCH CONDITION
func _on_Torch_Light():
	
	light = true
	
func coreSignals():
	
	
	emit_signal("heartsVisible", dimension)

	door = currentItemMap.get_node("Door")
	door.connect("level_complete", self, "_on_Door_level_complete")
		
	if currentItemMap.get_node("Torch") != null:
			
		torch = currentItemMap.get_node("Torch")
		torch.connect("torch_on_level", self, "_on_Torch_Light")
			
		if light == true:
				
			currentItemMap.get_node("Torch").get_node("AnimatedSprite").play("lit")
			door.state = true
			
	if currentItemMap.get_node("Heart") != null:
		heart = currentItemMap.get_node("Heart")
		heart.connect("health_increase", self, "HI_HUD")
	if currentItemMap.get_node("Heart2") != null:
		heart = currentItemMap.get_node("Heart2")
		heart.connect("health_increase", self, "HI_HUD")
	if currentItemMap.get_node("Heart3") != null:
		heart = currentItemMap.get_node("Heart3")
		heart.connect("health_increase", self, "HI_HUD")
		

func HI_HUD():
	
	emit_signal("heartGain", totalHearts)
	totalHearts += 1
	
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
	emit_signal("levelCam")
	print(sceneTree)
	print("red" + str(sceneTree.get_nodes_in_group("red").size()))
	print("purple" + str(sceneTree.get_nodes_in_group("purple").size()))
	print("levels" + str(sceneTree.get_nodes_in_group("levels").size()))

	match level_counter:
		1:
			level1(1)
		2: 
			level2(2)
		3:
			level2(2)
