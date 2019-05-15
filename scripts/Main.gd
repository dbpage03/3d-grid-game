extends Spatial

onready var camFP = self.get_node("FP")
onready var camTP = self.get_node("TP")

func _ready():
	set_process(true)
	camFP.set_translation(camTP.get_translation())
	



func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		if camFP.current == true:
			camFP.current = false
			camTP.current = true
		else:
			camFP.current = true
			camTP.current = false


func _on_UI_play():
	pass # Replace with function body.

func stuff():
	pass