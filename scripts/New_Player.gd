extends KinematicBody

const GRAVITY = -24
const MAX_SPEED = 5
const JUMP_SPEED = 10
const ACCEL = 4.5
const DEACCEL = 16
const MAX_SLOPE_ANGLE = 40
var vel = Vector3()

var camFP

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
	
	if Input.is_action_pressed("game_up"):
		input_movement_vector.y += 1
	if Input.is_action_pressed("game_down"):
		input_movement_vector.y -= 1
	if Input.is_action_pressed("game_left"):
		input_movement_vector.x -= 1
	if Input.is_action_pressed("game_right"):
		input_movement_vector.x += 1
	
	input_movement_vector = input_movement_vector.normalized()
	dir += -cam_xform.basis.z.normalized() * input_movement_vector.y
	dir += cam_xform.basis.x.normalized() * input_movement_vector.x
	
	if is_on_floor():
		if Input.is_action_just_pressed("movement_jump"):
			vel.y = JUMP_SPEED
	
	# Capturing/Freeing the cursor
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func process_movement(delta):
	pass

func _input(event):
	pass