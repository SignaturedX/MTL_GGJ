class_name Main
extends Node

onready var world_access = worlds.new()
onready var purpleChar = preload("res://Players/Purple.tscn")
onready var redChar = preload("res://Players/Red.tscn")
#onready var menuHelp = menu.new()
onready var purpleWorld = $Levels/Level1_P
onready var redWorld = $Levels/Level1_R
onready var mainMenu = $UI/MainMenu
var purpleInstance
var redInstance


# Called when the node enters the scene tree for the first time.
func _ready():
	_level0()
	$UI/PauseMenu.hide()
	mainMenu.hide()
	
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
		#menuHelp.call_main() 
		
		
func end_world():
	
	var groupSizeRED = get_tree().get_nodes_in_group("red").size()
	var groupSizePURPLE = get_tree().get_nodes_in_group("purple").size()

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
	

func _on_MainMenu_start_game():
	print("okay starting game")
