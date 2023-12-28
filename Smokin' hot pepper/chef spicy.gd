extends Node2D

@onready var animated_sprite_2d = $AnimatedSprite2D
var boss_attack = RandomNumberGenerator.new()
var current_attack = 0
var charge_laser = false
var fiend = false
var can_attack = true
var pepper_shot = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	attack()

func attack():
	if can_attack == true:
		var current_attack = boss_attack.randi_range(1, 3)
		can_attack = false
		current_attack = 1
		print("attack picked")
		if current_attack == 1:
			pepper_shot = true
			await get_tree().create_timer(1.5).timeout
			GameManager.pepper_shot = true
		if current_attack == 2:
			charge_laser = true
			await get_tree().create_timer(1.5).timeout
			charge_laser = false
			GameManager.pepper_laser = true
		if current_attack == 3:
			fiend = true
			await get_tree().create_timer(1.5).timeout
			GameManager.pepper_fiend = true
		current_attack = 0
		await get_tree().create_timer(1.5).timeout
		can_attack = true
