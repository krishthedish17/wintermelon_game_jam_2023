extends CharacterBody2D

@onready var bullet_area = $Area2D
@onready var fiend_box = $"../spicy fiends3/CollisionShape2D"
@export var speed: float = 200
@export var max_distance: float = -1000
@onready var player = $"../../melonboy"
@onready var bullet_sprite = $AnimatedSprite2D
var original_pos = position.x
var original_height = position.y
var distance = 0
var shooting = false
# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible = false
	shooting = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if shooting == true:
		bullet_sprite.play("default")
		shooting = true
		self.visible = true
		position.x -= speed * delta
		print(position.x)
		if distance > max_distance:
			distance = position.x - original_pos
		else:
			position.x = original_pos
			self.visible = false
			distance = 0
			GameManager.pepper_fiend = false
			shooting = false
	shoot()

func _on_bullet_connected(body):
	if body.is_in_group("player"):
		print("bro got shot rip")
		body.health_loss()
		position.x = original_pos
		self.visible = false
		distance = 0
		GameManager.pepper_fiend = false
		shooting = false

func shoot():
	if GameManager.pepper_fiend == true:
		shooting = true
	
