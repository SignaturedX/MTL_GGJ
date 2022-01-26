class_name menu
extends Control
signal start_game


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
		
func menu_process():
	get_tree().paused = true #pause everything except this menu
	visible = true #make this menu visible

#when the start button is pressed
func _on_Start_pressed():
	emit_signal("start_game") #emits a signal that is activated in the main
	get_tree().paused = false
	visible = false #makes the main menu UI invisible

#when the quit button is pressed
func _on_Quit_pressed():
	get_tree().quit() #closes the program


func _on_PauseMenu_quit_to_menu():
	menu_process()
