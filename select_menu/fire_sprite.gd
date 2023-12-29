extends Sprite2D

@onready var beat_sprite = $"../Sprite2D5"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GameManager.beat_fire == true:
		self.visible = false
		beat_sprite.visible = true
	if GameManager.beat_fire == false:
		self.visible = true
		beat_sprite.visible = false
