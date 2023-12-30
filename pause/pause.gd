extends Node

@export var can_toggle_pause: bool = true
@onready var texture_rect = $TextureRect
@onready var label = $Label
@onready var pause_music = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	label.visible = false
	texture_rect.visible = false
	pause_music.playing = false
func _process(delta):
	if Input.is_action_just_pressed("pause") && GameManager.health > -1 && GameManager.dying_boss == false:
		if !get_tree().paused:
			pause()
			label.visible = true
			texture_rect.visible = true
			pause_music.playing = true
		else:
			resume()
			label.visible = false
			texture_rect.visible = false
			pause_music.playing = false

func pause():
	get_tree().set_deferred("paused", true)

func resume():
	get_tree().set_deferred("paused", false)
