class_name Main
extends Node

onready var purpleChar = preload("res://Players/Purple.tscn")
onready var redChar = preload("res://Players/Red.tscn")
onready var mainMenu = $UI/MainMenu
var purpleInstance
var redInstance
var groupSizeRED
var groupSizePURPLE
var level

# Called when the node enters the scene tree for the first time.
func _ready():
	$UI/PauseMenu.hide()
	mainMenu.hide()
	$UI/AnimationPlayer.play("fade_to_normal")
	level = levels.new(get_tree())
	level.level0()
	
	
	
# Code inside block will be updated every frame
func _process(_delta):
	
	# for swapping between worlds
	var x_input = Input.is_action_just_pressed("dim_swap_key")

	if x_input != false:

		level.end_world() 
#
#	#players health stuff
#	groupSizePURPLE = get_tree().get_nodes_in_group("purple").size()
#	groupSizeRED = get_tree().get_nodes_in_group("red").size()
#
#	#player health stuff
#	if groupSizePURPLE != 0 and groupSizeRED == 0:
#		$UI/HUD.display_health(purpleInstance.health, null, "purple") #if there's a purple instance but no red
#	elif groupSizePURPLE == 0 and groupSizeRED != 0:
#		$UI/HUD.display_health(null, redInstance.health, "red") #if there's a red instance but no purple
#	elif groupSizePURPLE != 0 and groupSizeRED != 0:
#		$UI/HUD.display_health(purpleInstance.health, redInstance.health, "both")   #if both purple and red exist
#	else:
#		$UI/HUD.display_health(null, null, "neither") #if neither purple or red exist


func _on_MainMenu_start_game():
	level.clear_all()
	level.level0()


