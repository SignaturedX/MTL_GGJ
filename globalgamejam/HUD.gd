extends Control
var red_heart = preload("res://heart.png")
var purple_heart = preload("res://steel-heart.png")
var grey_heart = preload("res://grey-heart.png")
onready var heart_group = get_tree().get_nodes_in_group("hearts")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func display_health(health_p, health_r, dim):
	match dim:
		"purple":
			for i in health_p:
				heart_group[i].texture = purple_heart
		"red":
			for i in health_r:
				heart_group[i].texture = red_heart
		
