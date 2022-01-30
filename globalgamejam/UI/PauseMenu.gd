extends Control
signal quit_to_menu


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _process(_delta):
	if Input.is_action_pressed("ui_cancel"): #always is ready for user to press Esc
		get_tree().paused = true #pauses all processes but this one
		visible = true #makes this menu visible

#when the quit button is pressed
func _on_Quit_pressed():
	get_tree().quit() #closes the program

#when the resume button is pressed
func _on_Resume_pressed():
	get_tree().paused = false #unpauses the tree processes
	visible = false #makes this pause menu invisible

#when the qu
func _on_QuitToMenu_pressed():
	emit_signal("quit_to_menu")
	get_parent().get_node("HUD").visible = false
	visible = false
