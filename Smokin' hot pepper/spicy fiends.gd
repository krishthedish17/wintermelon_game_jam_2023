extends CharacterBody2D

@onready var bullet_area = $Area2D
@onready var fiend_box = $"../spicy fiends3/CollisionShape2D"
@export var speed: float = 200
@export var max_distance: float = -1000
@onready var player = $"../../melonboy"
@onready var bullet_sprite = $AnimatedSprite2D
@onready var hitbox = $Area2D/CollisionShape2D

var original_pos = position.x
var original_height = position.y
var distance = 0
var shooting = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible = false
	shooting = false
	hitbox.disabled = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if shooting == true:
		hitbox.disabled = false
		bullet_sprite.play("default")
		GameManager.is_fiend = true
		shooting = true
		self.visible = true
		position.x -= speed * delta
		if distance > max_distance:
			distance = position.x - original_pos
		else:
			position.x = original_pos
			position.y = original_height
			GameManager.is_fiend = false
			self.visible = false
			hitbox.disabled = true
			distance = 0
			GameManager.pepper_fiend = false
			shooting = false
	shoot()

func _physics_process(delta):
	if shooting == true:
		if position.y < 140:
			position.y += gravity * delta
func _on_bullet_connected(body):
	if body.is_in_group("player"):
		print("fiend hit")
		body.health_loss()
		position.x = original_pos
		position.y = original_height
		self.visible = false
		hitbox.disabled = true
		GameManager.is_fiend = false
		distance = 0
		GameManager.pepper_fiend = false
		shooting = false

func shoot():
	if GameManager.pepper_fiend == true:
		shooting = true
	
