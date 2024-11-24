extends CharacterBody2D

@onready var bullet_area = $Area2D/CollisionShape2D
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
	if shooting == true && payback == false:
		GameManager.is_pepper_shot = true
		bullet_sprite.play("default")
		shooting = true
		self.visible = true
		position.x -= speed * delta
		position.y -= bullet_fall * delta
		bullet_sprite.rotation = rotation_val
		bullet_area.rotation = rotation_val
		print(position.x)
		if distance > max_distance:
			distance = position.x - original_pos
		else:
			position.x = original_pos
			position.y = original_height
			self.visible = false
			distance = 0
			GameManager.pepper_shot = false
			shooting = false
			GameManager.is_pepper_shot = false
	if parried == true && payback == false:
		bullet_sprite.play("default")
		shooting = false
		GameManager.is_pepper_shot = true
		parried = true
		self.visible = true
		position.x += 2 * speed * delta
		print(position.x)
		if position.x > original_pos:
			position.x = original_pos
			position.y = original_height
			self.visible = false
			distance = 0
			GameManager.pepper_shot = false
			GameManager.parry_hit = true
			GameManager.is_pepper_shot = false
			shooting = false
			parried = false
	if shooting == true && payback == true && GameManager.fire_hit == true:
		GameManager.is_pepper_shot = true
		bullet_sprite.play("default")
		shooting = true
		self.visible = true
		position.x -= speed * delta
		position.y -= bullet_fall * delta
		bullet_sprite.rotation = rotation_val
		bullet_area.rotation = rotation_val
		print(position.x)
		if distance > max_distance:
			distance = position.x - original_pos
		else:
			position.x = original_pos
			position.y = original_height
			self.visible = false
			distance = 0
			GameManager.pepper_shot = false
			shooting = false
			GameManager.is_pepper_shot = false
	if payback == true && (GameManager.fire_hit == false):
		position.x = original_pos
		position.y = original_height
		self.visible = false
		distance = 0
		GameManager.pepper_shot = false
		shooting = false
		GameManager.is_pepper_shot = false
	if parried == true && payback == true && GameManager.fire_hit == true:
		bullet_sprite.play("default")
		shooting = false
		GameManager.is_pepper_shot = true
		parried = true
		self.visible = true
		position.x += 2 * speed * delta
		print(position.x)
		if position.x > original_pos:
			position.x = original_pos
			position.y = original_height
			self.visible = false
			distance = 0
			GameManager.pepper_shot = false
			GameManager.parry_hit = true
			GameManager.is_pepper_shot = false
			shooting = false
			parried = false
	shoot()

func _on_bullet_connected(body):
	if body.is_in_group("player"):
		print("pepper hit")
		body.health_loss()
		position.x = original_pos
		position.y = original_height
		self.visible = false
		distance = 0
		GameManager.pepper_shot = false
		GameManager.is_pepper_shot = false
		shooting = false

func shoot():
	if GameManager.pepper_shot == true:
		shooting = true

func _on_parried(area):
	if area.is_in_group("parry"):
		parried = true
