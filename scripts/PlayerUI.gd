extends Control

onready var hotbar = [self.get_node("Hotbar"), self.get_node("Hotbar/HBoxContainer/1"), self.get_node("Hotbar/HBoxContainer/2"), self.get_node("Hotbar/HBoxContainer/3"), self.get_node("Hotbar/HBoxContainer/4"), self.get_node("Hotbar/HBoxContainer/5"), self.get_node("Hotbar/HBoxContainer/6"), self.get_node("Hotbar/HBoxContainer/7"), self.get_node("Hotbar/HBoxContainer/8"), ]
onready var selection = self.get_node("Hotbar/Selection")
var selectionC = 1

func _ready():
	hide()

func _process(delta):
	get_node("HealthBar").value = get_parent().get_parent().get_node("Player").health
	pass

func _input(event):
	if event.is_action_pressed("ui_down"):
		if selectionC != 8:
			selectionC += 1
		else:
			selectionC = 1
		selection.position = hotbar[selectionC].rect_position + Vector2(4,4)
		pass
	if event.is_action_pressed("ui_up"):
		if selectionC != 1:
			selectionC -= 1
		else:
			selectionC = 8
		selection.position = hotbar[selectionC].rect_position + Vector2(4,4)
		pass

func _on_UI_play():
	show()
