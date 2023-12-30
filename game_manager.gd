extends Node

var main_scene: PackedScene = preload("res://main/main.tscn")
var lore_scene: PackedScene = preload("res://lore/lore_scene.tscn")
var tutorial: PackedScene = preload("res://levels/tutorial/tutorial.tscn")
var select_menu: PackedScene = preload("res://select_menu/select_menu.tscn")
var pepper_level: PackedScene = preload("res://Smokin' hot pepper/smokin'_hot_pepper.tscn")
var berry_level: PackedScene = preload("res://Betarying blueberry/Betraying blueberry.tscn")
var played_game = false
var health = 3
var is_tutorial = true
var pepper_laser = false
var pepper_fiend = false
var pepper_shot = false
var pepper_smoke = false
var player_pos: Vector2 = Vector2.ZERO
var parry_hit: = false
var can_parry: = true
var is_pepper_shot: = false
var is_beam: = false
var is_fiend: = false
var is_smoke: = false
var fire_health = 100
var fire_hit: = false
var beat_fire: = false
var berry_shot: = false
var is_berry_shot: = false
var berry_hit: = false
var wave_shot: = false
var is_wave_shot: = false
var is_hurricane: = false
var hurricane: = false
var is_mine: = false
var mine: = false
var berry_health: = 100
var beat_water: = false
var dying_boss: = false
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

func load_pepper_level() -> void:
	is_tutorial = false
	get_tree().change_scene_to_packed(pepper_level)
	
func load_berry_level() -> void:
	is_tutorial = false
	get_tree().change_scene_to_packed(berry_level)

