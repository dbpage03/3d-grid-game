extends KinematicBody

onready var camFP = self.get_parent().get_node("FP")
onready var camTP = self.get_parent().get_node("TP")
const SPEED = 4
const ROTSPEED = 4
var velocity = Vector3()
var play = true

# Called when the node enters the scene tree for the first time.
func _ready():
	get_viewport().warp_mouse(Vector2(200,200))
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

func sideways(way):
	var a = degRad(self.rotation_degrees.y)
	var x
	var z
	z = sin(a) * SPEED * way
	x = -cos(a) * SPEED * way
	self.move_and_slide(Vector3(x,0,z))
	pass

func mouse():
	var x = -(get_viewport().get_mouse_position().x - 200) / 10 * ROTSPEED
	var y = (get_viewport().get_mouse_position().y - 200) / 10 * ROTSPEED
	camFP.rotate_y(degRad(x))
	var t = camFP.get_transform()
	t.basis = Basis(t.basis.x.normalized(), deg2rad(-y))*t.basis
	camFP.set_transform(t)
	if play:
		get_viewport().warp_mouse(Vector2(200,200))

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_FOCUS_OUT:
		play = false
	if what == MainLoop.NOTIFICATION_WM_FOCUS_IN:
		play = true

func _physics_process(delta):
	if play:
		pass
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if play:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		
		self.rotation.y = camFP.rotation.y
		camFP.translation.x = self.translation.x
		camFP.translation.z = self.translation.z
		camFP.translation.y = self.translation.y
		
		if Input.is_action_pressed("game_left"):
			sideways(1)
		if Input.is_action_pressed("game_right"):
			sideways(-1)
		if Input.is_action_pressed("game_up"):
			forward()
		if Input.is_action_pressed("game_down"):
			backward()
		mouse()
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
