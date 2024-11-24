extends Node2D

@onready var sprite = $AnimatedSprite2D
@onready var animation_player = $"../AnimationPlayer"
@onready var texture_rect = $TextureRect
@onready var hit_player = $"hit player"
@onready var bg_music = $"../bg music"



var health = 100
var boss_attack = RandomNumberGenerator.new()
var current_attack = 0
var charge_laser = false
var smoke = false
var fiend = false
var can_attack = true
var pepper_shot = true
var hit = false
var invuln = false
var started_laser = false
var losing_health = false
var dead = false
var started_fight = false
var laser_last_attack = false

# Called when the node enters the scene tree for the first time.
func _ready():
	health = 100
	GameManager.is_tutorial = false
	GameManager.health = 3
	dead = false
	texture_rect.visible = false
	laser_last_attack = false
	sprite.play("intro")
	await get_tree().create_timer(2).timeout
	started_fight = true
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dead == false && started_fight == true:
		attack()
		taking_damage()
		health_loss()
	death()
	GameManager.fire_health = health
	if GameManager.health == 0:
		started_fight = false
	if GameManager.health <= 0:
		bg_music.playing = false
	if GameManager.dying_boss == true:
		bg_music.playing = false

func attack():
	if can_attack == true:
		var current_attack = boss_attack.randi_range(1, 5)
		if GameManager.is_pepper_shot:
			current_attack = boss_attack.randi_range(2, 4)
		if GameManager.is_beam || laser_last_attack == true:
			while current_attack == 2:
				current_attack = boss_attack.randi_range(1, 5)
		if GameManager.is_fiend:
			while current_attack == 3:
				current_attack = boss_attack.randi_range(1, 5)
		if GameManager.is_smoke:
			while current_attack == 4:
				current_attack = boss_attack.randi_range(1, 5)
		
		can_attack = false
		
		print("attack picked")
		if (current_attack == 1 || current_attack == 5) && (GameManager.is_pepper_shot == false):
			pepper_shot = true
			await get_tree().create_timer(1.7).timeout
			GameManager.pepper_shot = true
			await get_tree().create_timer(2.4).timeout
			laser_last_attack = false
		if current_attack == 2 && GameManager.is_beam == false:
			charge_laser = true
			print("laser")
			await get_tree().create_timer(1.8).timeout
			GameManager.pepper_laser = true
			await get_tree().create_timer(3.2).timeout
			laser_last_attack = true
		if current_attack == 3 && GameManager.is_fiend == false:
			fiend = true
			await get_tree().create_timer(0.3).timeout
			GameManager.pepper_fiend = true
			laser_last_attack = false
		if current_attack == 4 && GameManager.is_smoke == false:
			smoke = true
			await get_tree().create_timer(0.5).timeout
			GameManager.pepper_smoke = true
			laser_last_attack = false
		current_attack = 0
		await get_tree().create_timer(1.5).timeout
		can_attack = true


func _on_area_2d_area_entered(area):
	if area.is_in_group("knife"):
		if hit == false && invuln == false:
			print("hit")
			await get_tree().create_timer(0.1).timeout
			hit = true
			GameManager.fire_hit = true
			invuln = true
func taking_damage():
	if hit == true || GameManager.parry_hit == true:
		print("playing anim")	
		hit_player.play("hit")
		losing_health = true
		GameManager.pepper_shot = true
		await get_tree().create_timer(0.8).timeout
		invuln = false
		hit = false
		GameManager.fire_hit = false
		GameManager.parry_hit = false
	elif charge_laser == false && fiend == false && hit == false && smoke == false && pepper_shot == false && dead == false:
		sprite.play("Idle")
	if charge_laser == true && dead == false:
		sprite.play("fire")
		print("laser anim")
		await get_tree().create_timer(5).timeout
		charge_laser = false
	if fiend == true && dead == false:
		sprite.play("pan flip")
		await get_tree().create_timer(0.6).timeout
		fiend = false
	if smoke == true && dead == false:
		sprite.play("smoke")
		await get_tree().create_timer(1).timeout
		smoke = false
	if pepper_shot == true && dead == false:
		sprite.play("pepper shot")
		await get_tree().create_timer(2.4).timeout
		pepper_shot = false

func health_loss():
	if losing_health == true:
		losing_health = false
		for i in range(10):
			if GameManager.parry_hit == true:
				health -= 0.04166666667
			else:
				health -= 0.02083333333
			print("health" + str(health))
			await get_tree().create_timer(0.2).timeout
	
func death():
	if health <= 0:
		dead = true
		sprite.play("dead")
		texture_rect.visible = true
		GameManager.dying_boss = true
		GameManager.beat_fire = true
		animation_player.play("win")
		await get_tree().create_timer(4).timeout
		GameManager.dying_boss = false
		GameManager.load_select_screen()
		queue_free()
