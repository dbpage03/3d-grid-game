extends KinematicBody

const GRAVITY = -32
const MAX_SPEED = 8
const JUMP_SPEED = 15
const MAX_SLOPE_ANGLE = 40
var vel = Vector3()
onready var camFP = self.get_parent().get_node("FP")
var MOUSE_SENSITIVITY = 0.2
var dir = Vector3() 

func _ready():
	pass

func _physics_process(delta):
	process_input(delta)
	process_movement(delta)
	pass

func process_input(delta):
	var cam_xform = camFP.get_global_transform()
	var input_movement_vector = Vector2()
	dir = Vector3()
	
	if Input.is_action_pressed("game_up"):
		input_movement_vector.y += 1
	if Input.is_action_pressed("game_down"):
		input_movement_vector.y -= 1
	if Input.is_action_pressed("game_left"):
		input_movement_vector.x += 1
	if Input.is_action_pressed("game_right"):
		input_movement_vector.x -= 1
	
	dir.x = input_movement_vector.x
	dir.z = input_movement_vector.y
	
	if is_on_floor():
		if Input.is_action_just_pressed("game_jump"):
			vel.y = JUMP_SPEED
	
	# Capturing/Freeing the cursor
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func process_movement(delta):
	vel.y += GRAVITY * delta
	
	var a = deg2rad(self.rotation_degrees.y + 90)
	vel.z = -sin(a) * MAX_SPEED * dir.z
	vel.x = cos(a) * MAX_SPEED * dir.z
	
	a = deg2rad(self.rotation_degrees.y)
	vel.z += sin(a) * MAX_SPEED * dir.x
	vel.x += -cos(a) * MAX_SPEED * dir.x
	
	vel = move_and_slide(vel, Vector3(0,1,0), 0.05, 4, deg2rad(MAX_SLOPE_ANGLE))
	camFP.translation.x = self.translation.x
	camFP.translation.z = self.translation.z
	camFP.translation.y = self.translation.y
	

func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		var t = camFP.get_transform()
		t.basis = Basis(t.basis.x.normalized(), deg2rad(-event.relative.y * MOUSE_SENSITIVITY))*t.basis
		camFP.set_transform(t)
		camFP.rotate_y(deg2rad(-event.relative.x * MOUSE_SENSITIVITY))
		
		var camera_rot = camFP.rotation_degrees
		camera_rot.x = clamp(camera_rot.x, -70, 70)
		camFP.rotation_degrees = camera_rot
		
		self.rotation_degrees.y = camFP.rotation_degrees.y
	
	