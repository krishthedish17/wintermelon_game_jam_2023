extends Node

@onready var loading_screen_scene = preload("res://load/load.tscn")

var scene_to_load_path
var loading_screen_scene_instance
var loading = false

func load_scene(path):
	var current_scene = get_tree().current_scene
	
	loading_screen_scene_instance = loading_screen_scene.instantiate()
	get_tree().root.call_deferred("add_child", loading_screen_scene_instance)
		
	ResourceLoader.load_threaded_request(path)
	
	print("current scene" + str(current_scene))
	current_scene.queue_free()
	
	loading = true
	scene_to_load_path = path
	print("loaded path" + str(scene_to_load_path))
	

func _process(delta):
	if not loading:
		return
	
	var progress = []	
	var status = ResourceLoader.load_threaded_get_status(scene_to_load_path, progress)
	
	print("status" + str(status))
	
	if status == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
		print("loading")
		var progressbar = loading_screen_scene_instance.get_node("load_bar")
		progressbar.value = progress[0] * 100
	elif status == ResourceLoader.THREAD_LOAD_LOADED:
		print("loaded")
		get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get((scene_to_load_path)))
		loading_screen_scene_instance.queue_free()
		loading = false
	else:
		print("error loading progress bar")
	
		
