extends CanvasLayer


export (float) var transition_speed = 0.5


onready var current_scene = $current_scene
onready var next_scene = $next_scene
onready var tween = $Tween


var width


func _ready():
	width = current_scene.get_child(0).get_rect().size.x
	
	print("Scene width: ", width)
	
	#set the offset of the scene by the width of the current scene
	next_scene.offset.x = width
	
	
# warning-ignore:return_value_discarded
	SceneManager.connect("go_to_next_scene", self, "_on_go_to_next_scene")
# warning-ignore:return_value_discarded
	SceneManager.connect("go_to_prev_scene", self, "_on_go_to_prev_scene")



func _transition_to_next_scene():
	tween.interpolate_property(current_scene, "offset", Vector2(0,0), Vector2(-width, 0), transition_speed,  Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.interpolate_property(next_scene, "offset", Vector2(width,0), Vector2(0, 0), transition_speed,  Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()



func _transition_to_prev_scene():
	tween.interpolate_property(current_scene, "offset", Vector2(-width,0), Vector2(0, 0), transition_speed,  Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.interpolate_property(next_scene, "offset", Vector2(0,0), Vector2(width, 0), transition_speed,  Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.start()



func _on_go_to_next_scene(next, _prev):
	for scene in next_scene.get_children():
		scene.queue_free()
	
	
	var scene_child = next.instance()
	next_scene.add_child(scene_child)
	
	
	_transition_to_next_scene()



func _on_go_to_prev_scene():
	for scene in current_scene.get_children():
		scene.queue_free()

	var scene_child = SceneManager.previous_scene.instance()
	current_scene.add_child(scene_child)
	
	
	_transition_to_prev_scene()
