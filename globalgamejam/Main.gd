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
var mainLevelCounter
var animation_finished

# Called when the node enters the scene tree for the first time.
func _ready():
	$UI/PauseMenu.hide()
	mainMenu.hide()
	$UI/AnimationPlayer.play("fade_to_normal")
#	level = levels.new()
#	level.level0()
#	mainLevelCounter = level.level_counter
	
	
# Code inside block will be updated every frame
func _process(_delta):
	
	if !$AudioStreamPlayer.playing:
		$AudioStreamPlayer.play()
#	if level.level_counter != mainLevelCounter:
#		print("ANIMATING!!!!!!")
#		animate()
#		mainLevelCounter = level.level_counter
	# for swapping between worlds
	pass 
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

func animate():
	$UI/AnimationPlayer.play("fade_to_black")

func _on_MainMenu_start_game():
#	level.clear_all()
#	level.level0()
	pass

func _on_AnimationPlayer_animation_finished(_anim_name):
	animation_finished = true
	$UI/ColorRect.visible = false
	print("animation finished")
	
