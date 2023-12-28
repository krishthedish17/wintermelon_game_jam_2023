extends AnimatedSprite2D

@onready var bullet_area = $Area2D
@export var speed: float = 200
@export var max_distance: float = -500
@onready var player = $"../../melonboy"
@onready var laser_sprite = $"."
@onready var hitbox = $"../Area2D/CollisionShape2D"
var distance = 0
var shooting = false
var parried = false
# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible = false
	shooting = false
	hitbox.disabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GameManager.pepper_laser == true:
		self.visible = true
		hitbox.disabled = false
		await get_tree().create_timer(3).timeout
		self.visible = false
		hitbox.disabled = true
		GameManager.pepper_laser = false
	





func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		print("bro got shot rip")
		body.health_loss()
