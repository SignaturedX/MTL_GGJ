extends Control
var red_heart = preload("res://heart.png")
var purple_heart = preload("res://steel-heart.png")
var grey_heart = preload("res://grey-heart.png")
onready var heart_group_red = get_node("red_bar").get_children()
onready var heart_group_purple = get_node("purple_bar").get_children()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func display_health(health_p=0, health_r=0):
	
			
	for i in health_p:
				
		heart_group_purple[i].texture = purple_heart
			
	for i in health_r:

		heart_group_red[i].texture = red_heart

func _on_Levels_heartGain(heartNum):
	
	display_health(heartNum, heartNum)


func _on_Levels_heartsVisible(dim):
	
	for i in range(heart_group_purple.size()):
		
		if dim == "red":
		
			heart_group_purple[i].visible = false
			heart_group_red[i].visible = true
		
		elif dim == "purple":
		
			heart_group_purple[i].visible = true
			heart_group_red[i].visible = false
	
