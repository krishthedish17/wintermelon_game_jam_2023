extends Node2D

@onready var full = $full
@onready var two = $"2"
@onready var one = $"1"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GameManager.health == 3:
		full.visible = true
	elif GameManager.health == 2:
		two.visible = true
		full.visible = false
	elif GameManager.health == 1:
		one.visible = true
		two.visible = false
	else:
		one.visible = false
