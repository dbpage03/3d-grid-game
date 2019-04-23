extends KinematicBody

onready var camFP = self.get_parent().get_node("FP")
onready var camTP = self.get_parent().get_node("TP")

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)

func degRad(degrees):
	return degrees * PI/180

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.rotation.y = camFP.rotation.y
	
	if Input.is_action_pressed("game_left"):
		camFP.rotate_y(degRad(1))
	if Input.is_action_pressed("game_right"):
		camFP.rotate_y(degRad(-1))
	if Input.is_action_pressed("game_up"):
		
		pass
	if Input.is_action_pressed("game_down"):
		
		pass
