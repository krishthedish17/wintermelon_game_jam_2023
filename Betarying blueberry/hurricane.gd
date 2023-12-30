extends CharacterBody2D

@onready var bullet_area = $Area2D
@export var speed: float = 200
@export var max_distance: float = -1000
@onready var player = $"../../melonboy"
@onready var bullet_sprite = $AnimatedSprite2D
@export var payback = false
@export var bullet_fall = 1
@export var rotation_val = 45

var original_pos = position.x
var original_height = position.y
var distance = 0
var shooting = false
var parried = false


# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible = false
	shooting = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if shooting == true:
		GameManager.hurricane = true
		GameManager.is_hurricane = true
		bullet_sprite.play("default")
		shooting = true
		self.visible = true
		await get_tree().create_timer(10).timeout
		position.x = original_pos
		position.y = original_height
		self.visible = false
		distance = 0
		GameManager.hurricane = false
		shooting = false
		GameManager.is_hurricane = false
	shoot()

func _on_bullet_connected(body):
	if body.is_in_group("player"):
		print("bro got shot rip")
		body.health_loss()
		position.x = original_pos
		position.y = original_height
		self.visible = false
		distance = 0
		GameManager.hurricane = false
		GameManager.is_hurricane = false
		shooting = false

func shoot():
	if GameManager.hurricane == true:
		shooting = true

