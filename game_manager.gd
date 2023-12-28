extends Node

var main_scene: PackedScene = preload("res://main/main.tscn")
var lore_scene: PackedScene = preload("res://lore/lore_scene.tscn")

var played_game = false

func load_lore_scene() -> void:
	get_tree().change_scene_to_packed(lore_scene)
	await get_tree().create_timer(30).timeout
	print("done")
	GameManager.load_game_scene()
	
func load_main_scene() -> void:
	get_tree().change_scene_to_packed(main_scene)

func load_game_scene() -> void:
	get_tree().change_scene_to_packed(main_scene)
	var played_game = true
