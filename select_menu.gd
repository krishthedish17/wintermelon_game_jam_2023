extends Node

@onready var win_button = $Button5


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GameManager.beat_fire == true && GameManager.beat_water == true && GameManager.won == false:
		GameManager.load_win_scene()
	
	if GameManager.won == true:
		win_button.visible = true
	else:
		win_button.visible = false


func _on_tutorial_pressed():
	GameManager.load_tutorial()
	GameManager.is_tutorial = true






func _on_fire_pressed():
	GameManager.load_pepper_level()
	GameManager.is_tutorial = false


func _on_berry_pressed():
	GameManager.load_berry_level()
	GameManager.is_tutorial = false


func _on_menu_pressed():
	GameManager.load_main_scene()


func _on_win_button():
	GameManager.load_win_scene()
