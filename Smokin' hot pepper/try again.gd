extends Button

@onready var return_to_menu = $"return to menu"
var grabbed_focus = false
# Called when the node enters the scene tree for the first time.
func _ready():
	grabbed_focus = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GameManager.health <= 0:
		self.disabled = false
		return_to_menu.disabled = false
		if grabbed_focus == false:
			self.grab_focus()
			grabbed_focus = true
		
	else:
		self.disabled = true
		return_to_menu.disabled = true
		


func _on_pressed():
	GameManager.load_pepper_level()
		
	


func _on_return_to_menu_pressed():
	GameManager.load_select_screen()
