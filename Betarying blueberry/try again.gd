extends Button

@onready var return_to_menu = $"../Button"
var focus = false
# Called when the node enters the scene tree for the first time.
func _ready():
	focus = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GameManager.health <= 0:
		self.disabled = false
		return_to_menu.disabled = false
		if focus == false:
			$".".grab_focus()
			focus = true
	else:
		self.disabled = true
		return_to_menu.disabled = true
		


func _on_pressed():
	GameManager.load_berry_level()
		
	


func _on_return_to_menu_pressed():
	GameManager.load_select_screen()
