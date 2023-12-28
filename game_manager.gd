extends Node

var main_scene: PackedScene = preload("res://main/main.tscn")
var lore_scene: PackedScene = preload("res://lore/lore_scene.tscn")
var tutorial: PackedScene = preload("res://levels/tutorial/tutorial.tscn")
var select_menu: PackedScene = preload("res://select_menu/select_menu.tscn")
#var pepper_level: PackedScene = preload("res://Smokin' hot pepper/smokin'_hot_pepper_level.tscn")
var played_game = false
var health = 3
var is_tutorial = true

func load_lore_scene() -> void:
	get_tree().change_scene_to_packed(lore_scene)
	await get_tree().create_timer(30).timeout
	print("done")
	GameManager.load_select_screen()
	
func load_main_scene() -> void:
	get_tree().change_scene_to_packed(main_scene)

func load_game_scene() -> void:
	get_tree().change_scene_to_packed(main_scene)
	var played_game = true

func load_tutorial() -> void:
	is_tutorial = true
	get_tree().change_scene_to_packed(tutorial)

func load_select_screen() -> void:
	is_tutorial = false
	get_tree().change_scene_to_packed(select_menu)

#func load_pepper_level() -> void:
	#get_tree().change_scene_to_packed(pepper_level)
	
