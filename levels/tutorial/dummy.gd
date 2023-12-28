extends CharacterBody2D

@onready var dummy_sprite = $AnimatedSprite2D

var hit = false
var invuln = false

func _process(_delta):
	# Calling functions
	dummy_animations()

func dummy_animations():
	if hit == true:
		print("playing anim")
		dummy_sprite.play("hit")
		await get_tree().create_timer(0.8).timeout
		invuln = false
		hit = false
	else:
		dummy_sprite.play("Idle")



	


func _on_area_2d_area_entered(area):
	if area.is_in_group("knife"):
		if hit == false && invuln == false:
			print("hit")
			await get_tree().create_timer(0.1).timeout
			hit = true
			invuln = true

