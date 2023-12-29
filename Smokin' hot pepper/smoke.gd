extends CharacterBody2D

@onready var bullet_area = $Area2D
@export var speed: float = 100
@export var max_distance: float = -1000
@onready var player = $"../../melonboy"
@onready var bullet_sprite = $AnimatedSprite2D
@export var bullet_fall = -30
var original_pos = position.x
var original_height = position.y
var distance = 0
var shooting = false
var going_down = true
# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible = false
	shooting = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if shooting == true:
		bullet_sprite.play("default")
		GameManager.is_smoke = true
		shooting = true
		self.visible = true
		position.x -= speed * delta
		if position.y < (original_height + 150) && going_down == true:
			position.y -= bullet_fall * delta
		else:
			going_down = false
		if position.y > (original_height - 50) && going_down == false:
			position.y += bullet_fall * delta
		else:
			going_down = true
		
		print(position.x)
		if distance > max_distance:
			distance = position.x - original_pos
		else:
			position.x = original_pos
			position.y = original_height
			GameManager.is_smoke = false
			self.visible = false
			distance = 0
			GameManager.pepper_smoke = false
			shooting = false
	shoot()

func _on_bullet_connected(body):
	if body.is_in_group("player"):
		print("bro got shot rip")
		body.health_loss()
		position.x = original_pos
		position.y = original_height
		self.visible = false
		GameManager.is_smoke = false
		distance = 0
		GameManager.pepper_smoke = false
		shooting = false

func shoot():
	if GameManager.pepper_smoke == true:
		shooting = true

