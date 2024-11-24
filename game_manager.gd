extends Node

var save_path = "user://variable.save"

var main_scene = "res://main/main.tscn"
var lore_scene = "res://lore/lore_scene.tscn"
var tutorial  = "res://levels/tutorial/tutorial.tscn"
var select_menu = "res://select_menu/select_menu.tscn"
var pepper_level = "res://Smokin' hot pepper/smokin'_hot_pepper.tscn"
var berry_level = "res://Betarying blueberry/Betraying blueberry.tscn"
var win = "res://win/win.tscn"
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
var won: = false
func load_lore_scene():
	Load.load_scene(lore_scene)
	
func load_main_scene() -> void:
	Load.load_scene(main_scene)

func load_game_scene() -> void:
	Load.load_scene(main_scene)
	var played_game = true

func load_tutorial() -> void:
	is_tutorial = true
	Load.load_scene(tutorial)

func load_select_screen() -> void:
	is_tutorial = false
	Load.load_scene(select_menu)

func load_pepper_level() -> void:
	is_tutorial = false
	Load.load_scene(pepper_level)
	
func load_berry_level() -> void:
	is_tutorial = false
	Load.load_scene(berry_level)

func load_win_scene() -> void:
	is_tutorial = false
	Load.load_scene(win)


