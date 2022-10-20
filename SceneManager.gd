#scene manager autoload
extends Node

var next_scene
var previous_scene


# warning-ignore:unused_signal
signal go_to_next_scene(next_scene, previous_scene)
# warning-ignore:unused_signal
signal go_to_prev_scene


func _ready():
# warning-ignore:return_value_discarded
	connect("go_to_next_scene", self, "_on_go_to_next_scene")


func _on_go_to_next_scene(nx_scene, prev_scene):
	next_scene = nx_scene
	previous_scene = prev_scene

