extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_pressed():
	GameManager.load_lore_scene()


func _on_savew():
	save()



func save():
	var file = FileAccess.open(GameManager.save_path, FileAccess.WRITE)
	file.store_var(GameManager.beat_fire)
	file.store_var(GameManager.beat_water)
	file.store_var(GameManager.won)

func load_data():
	if FileAccess.file_exists(GameManager.save_path):
		var file = FileAccess.open(GameManager.save_path, FileAccess.READ)
		GameManager.beat_fire = file.get_var(GameManager.beat_fire)
		GameManager.beat_water = file.get_var(GameManager.beat_water)
		GameManager.won = file.get_var(GameManager.won)
	else:
		print("no data saved")
		GameManager.beat_fire = false
		GameManager.beat_water = false
		GameManager.won = false


func _on_load():
	load_data()
