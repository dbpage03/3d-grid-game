extends KinematicBody

onready var camFP = self.get_parent().get_node("FP")
onready var camTP = self.get_parent().get_node("TP")
const SPEED = 2 
const ROTSPEED = 4
var lastMousePos = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)

func degRad(degrees):
	return degrees * PI/180

func forward():
	var a = degRad(self.rotation_degrees.y + 90)
	var x
	var z
	z = -sin(a) * SPEED
	x = cos(a) * SPEED
	self.move_and_slide(Vector3(x,0,z))

func backward():
	var a = degRad(self.rotation_degrees.y + 90)
	var x
	var z
	z = sin(a) * SPEED
	x = -cos(a) * SPEED
	self.move_and_slide(Vector3(x,0,z))

func mouse():
	var x = get_viewport().get_mouse_position().x - lastMousePos.x
	var y = get_viewport().get_mouse_position().y - lastMousePos.y
	camFP.rotate_y(degRad(x))
	camFP.rotate_z(degRad(y))
	lastMousePos = get_viewport().get_mouse_position()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.rotation.y = camFP.rotation.y
	camFP.translation.x = self.translation.x
	camFP.translation.z = self.translation.z
	camFP.translation.y = self.translation.y
	
	if Input.is_action_pressed("game_left"):
		camFP.rotate_y(degRad(ROTSPEED))
	if Input.is_action_pressed("game_right"):
		camFP.rotate_y(degRad(-ROTSPEED))
	if Input.is_action_pressed("game_up"):
		forward()
	if Input.is_action_pressed("game_down"):
		backward()
	if Input.is_action_just_pressed("ui_left"):
		camFP.rotate_y(degRad(90))
	mouse()
