extends CharacterBody2D

@onready var bullet_area = $Area2D
@export var speed: float = 200
@export var max_distance: float = -1000
@onready var player = $"../../melonboy"
@onready var bullet_sprite = $AnimatedSprite2D
@export var shot_fall: float = 1
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
		bullet_sprite.play("default")
		shooting = true
		self.visible = true
		position.x -= speed * delta
		position.y -= shot_fall * delta
		print(position.x)
		if distance > max_distance:
			distance = position.x - original_pos
		else:
			position.x = original_pos
			self.visible = false
			distance = 0
			shooting = false
	if parried == true:
		bullet_sprite.play("default")
		shooting = false
		parried = true
		self.visible = true
		position.x += 2 * speed * delta
		print(position.x)
		if position.x > original_pos:
			position.x = original_pos
			self.visible = false
			distance = 0
			GameManager.pepper_shot = false
			shooting = false
			parried = false
			
	shoot()

func _on_bullet_connected(body):
	if body.is_in_group("player"):
		print("bro got shot rip")
		body.health_loss()
		position.x = original_pos
		self.visible = false
		distance = 0
		GameManager.pepper_shot = false
		shooting = false
		parried = false

func shoot():
	if GameManager.pepper_shot == true:
		shooting = true
	

func _on_parried(area):
	if area.is_in_group("parry"):
		parried = true
		
			
