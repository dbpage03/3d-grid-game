extends Spatial

onready var camFP = self.get_node("FP")
onready var camTP = self.get_node("TP")

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		if camFP.current == true:
			camFP.current = false
			camTP.current = true
		else:
			camFP.current = true
			camTP.current = false
