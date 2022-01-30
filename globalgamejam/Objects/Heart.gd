extends Area2D
var body_entered
signal health_increase

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _on_Heart_body_entered(_body):
	emit_signal("health_increase")
	queue_free()
	#plays a sound
