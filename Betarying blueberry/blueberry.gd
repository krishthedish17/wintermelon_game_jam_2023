extends Node2D

@onready var sprite = $CharacterBody2D/AnimatedSprite2D
@onready var animation_player = $"../AnimationPlayer"
@onready var texture_rect = $"../boss ui/win screen"
@onready var hit_player = $"hit player"
@onready var collision_shape_2d = $CharacterBody2D/CollisionShape2D
@onready var area_2d = $CharacterBody2D/Area2D
@onready var bg_music = $"../bg music"

var health = 100
var boss_attack = RandomNumberGenerator.new()
var current_attack = 0
var ball_charge = false
var hurricane = false
var wave = false
var can_attack = true
var berry_shot = false
var hit = false
var invuln = false
var started_laser = false
var losing_health = false
var dead = false
var started_fight = false
var original_pos = position.x
var forward = false
var is_ball = false
var mine = false
var attacking = false
var play_dead = false
# Called when the node enters the scene tree for the first time.
func _ready():
	health = 100
	GameManager.is_tutorial = false
	GameManager.health = 3
	dead = false
	started_fight = false
	texture_rect.visible = false
	attacking = false
	#texture_rect.visible = false
	sprite.play("intro")
	await get_tree().create_timer(2.1).timeout
	started_fight = true
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dead == false && started_fight == true:
		attack()
		taking_damage()
		health_loss()
		roll()
	death()
	GameManager.berry_health = health
	if GameManager.health == 0:
		started_fight = false
	if is_ball:
		collision_shape_2d.disabled = true
	else:
		collision_shape_2d.disabled = false
	if GameManager.health <= 0:
		bg_music.playing = false
	if GameManager.dying_boss == true:
		bg_music.playing = false
func attack():
	if can_attack == true:
		var current_attack = boss_attack.randi_range(1, 5)
		if GameManager.is_berry_shot:
			current_attack = boss_attack.randi_range(2, 4)
		if is_ball:
			while current_attack == 2:
				current_attack = boss_attack.randi_range(1, 5)
		if GameManager.is_wave_shot:
			while current_attack == 3:
				current_attack = boss_attack.randi_range(1, 5)
		if GameManager.is_hurricane:
			while current_attack == 4:
				current_attack = boss_attack.randi_range(1, 5)
		if GameManager.is_mine:
			current_attack = boss_attack.randi_range(1, 4)
		
		can_attack = false
		
		if (current_attack == 1) && (GameManager.is_berry_shot == false):
			berry_shot = true
			attacking = true
			GameManager.is_berry_shot = true
			await get_tree().create_timer(0.8).timeout
			GameManager.berry_shot = true
			await get_tree().create_timer(1).timeout
			attacking = false
			GameManager.is_berry_shot = false
		if current_attack == 2 && is_ball == false:
			ball_charge = true
			is_ball = true
			attacking = true
			await get_tree().create_timer(2).timeout
			forward = true
			ball()
			await get_tree().create_timer(11).timeout
			attacking = false
			is_ball = false
			ball_charge = false
		
		if current_attack == 3 && GameManager.wave_shot == false:
			wave = true
			attacking = true
			await get_tree().create_timer(1.8).timeout
			GameManager.wave_shot = true
			attacking = false
		
		if current_attack == 4 && GameManager.is_hurricane == false:
			hurricane = true
			attacking = true
			await get_tree().create_timer(1.2).timeout
			GameManager.hurricane = true
			attacking = false
		
		if current_attack == 5 && GameManager.is_mine == false:
			mine = true
			attacking = true
			await get_tree().create_timer(1.6).timeout
			GameManager.mine = true
			await get_tree().create_timer(1.6).timeout
			attacking = false
		
		current_attack = 0
		attacking = false
		await get_tree().create_timer(1.5).timeout
		attacking = false
		can_attack = true


func _on_area_2d_area_entered(area):
	if area.is_in_group("knife"):
		if hit == false && invuln == false:
			await get_tree().create_timer(0.1).timeout
			hit = true
			GameManager.fire_hit = true
			await get_tree().create_timer(0.2).timeout
			invuln = true
func taking_damage():
	if hit == true || GameManager.parry_hit == true:
		hit_player.play("hit")
		losing_health = true
		GameManager.berry_shot = true
		await get_tree().create_timer(0.8).timeout
		invuln = false
		hit = false
		GameManager.fire_hit = false
		GameManager.parry_hit = false
	
	if attacking == false:
		#ball_charge == false && wave == false && hit == false && hurricane == false && berry_shot == false && dead == false && mine == false
		sprite.play("Idle")
	
	if ball_charge == true && dead == false && attacking == true:
		sprite.play("ball")
		roll()
		await get_tree().create_timer(12.2).timeout
	if wave == true && dead == false && attacking == true:
		sprite.play("wave")
		await get_tree().create_timer(3).timeout
		wave = false
	if hurricane == true && dead == false && attacking == true:
		sprite.play("hurricane")
		await get_tree().create_timer(2.2).timeout
		hurricane = false
	if berry_shot == true && dead == false && attacking == true:
		sprite.play("berry shot")
		await get_tree().create_timer(1.8).timeout
		berry_shot = false
	if mine == true && dead == false && attacking == true:
		sprite.play("mine")
		await get_tree().create_timer(3.2).timeout
		mine = false

func health_loss():
	if losing_health == true:
		losing_health = false
		for i in range(10):
			if GameManager.parry_hit == true:
				health -= 0.04166666667
			else:
				health -= 0.02083333333
			await get_tree().create_timer(0.2).timeout
	
func death():
	if health <= 0:
		dead = true
		sprite.play("dead")
		GameManager.dying_boss = true
		texture_rect.visible = true
		GameManager.beat_water = true
		animation_player.play("win")
		await get_tree().create_timer(5).timeout
		GameManager.dying_boss = false
		GameManager.load_select_screen()
		queue_free()

func ball():
	while position.x > -600 && forward == true:
		position.x -= 20
		await get_tree().create_timer(0.1).timeout
	forward = false
	if forward == false && is_ball:
		while position.x < original_pos:
			position.x += 20
			await get_tree().create_timer(0.1).timeout
	
	




func _on_area_2d_body_entered(body):
	if is_ball:
		if body.is_in_group("player"):
			print("rolled")
			body.health_loss()

func roll():
	if ball_charge:
		$CharacterBody2D.position.y = 13
		sprite.rotation_degrees -= 5
		await get_tree().create_timer(0.1).timeout
	if not ball_charge:
		$CharacterBody2D.position.y = 0
		if sprite.rotation_degrees < 0:
			if sprite.rotation_degrees <= -360:
				sprite.rotation_degrees += 360
			sprite.rotation_degrees += 5
			await get_tree().create_timer(0.1).timeout
			
