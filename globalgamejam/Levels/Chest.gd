extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_Chest_area_entered(area):
	if not $AnimationPlayer.playing:
		$AnimationPlayer.play("epic_animation")


func _on_Chest2_area_entered(area):
	if not $AnimationPlayer.playing:
		$AnimationPlayer.play("epic_animation")
