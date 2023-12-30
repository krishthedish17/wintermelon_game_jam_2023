extends CharacterBody2D

@onready var bullet_area = $Area2D
@export var speed: float = 200
@export var max_distance: float = -1000
@onready var bullet_sprite = $AnimatedSprite2D
@onready var player = $"../../melonboy"
@export var payback = false
@export var bullet_fall = 1
@export var rotation_val = 45
@export var timing = 1
var original_pos = position.x
var original_height = position.y
var distance = 0
var shooting = false
var parried = false
var layer = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible = false
	shooting = false
	layer = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if shooting == true && layer == timing:
		rise()
		GameManager.mine = true
		GameManager.is_mine = true
		bullet_sprite.play("default")
		shooting = true
		self.visible = true
		await get_tree().create_timer(9).timeout
		sink()
		await get_tree().create_timer(1.7).timeout
		position.x = original_pos
		position.y = original_height
		self.visible = false
		distance = 0
		GameManager.mine = false
		shooting = false
		GameManager.is_mine = false

	shoot()

func _on_bullet_connected(body):
	if body.is_in_group("player") && GameManager.is_mine:
		print("bro got shot rip")
		body.health_loss()
		position.x = original_pos
		position.y = original_height
		self.visible = false
		distance = 0
		GameManager.mine = false
		GameManager.is_mine = false
		shooting = false

func shoot():
	if GameManager.mine == true:
		shooting = true

func rise():
	if position.y > 393:
		position.y -= 0.5
		await get_tree().create_timer(0.1).timeout

func sink():
	if position.y < 442:
		position.y += 1
		await get_tree().create_timer(0.1).timeout
