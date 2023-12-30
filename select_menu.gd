extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_tutorial_pressed():
	GameManager.load_tutorial()
	GameManager.is_tutorial = true
	




func _on_fire_pressed():
	GameManager.load_pepper_level()
	GameManager.is_tutorial = false


func _on_berry_pressed():
	GameManager.load_berry_level()
	GameManager.is_tutorial = false
