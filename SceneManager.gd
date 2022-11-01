#scene manager autoload
extends Node

var next_scene
var previous_scene = []


# warning-ignore:unused_signal
signal go_to_next_scene(next_scene, previous_scene)
# warning-ignore:unused_signal
signal go_to_prev_scene


func _ready():
	# warning-ignore:return_value_discarded
	connect("go_to_next_scene", self, "_on_go_to_next_scene")
	
	# Handles phone back buttons being pressed
	get_tree().set_quit_on_go_back(false)



func _notification(what):
	# When the android back button is pressed, go to the previous scene
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		if previous_scene.empty() == false:
			emit_signal("go_to_prev_scene")
		else:
			get_tree().quit()



func _on_go_to_next_scene(nx_scene, prev_scene):
	next_scene = nx_scene
	previous_scene.append(prev_scene)

