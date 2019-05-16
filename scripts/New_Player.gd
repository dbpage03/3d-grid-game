extends KinematicBody

const GRAVITY = -32
const MAX_SPEED = 8
const JUMP_SPEED = 15
const SPRINT_MULT = 1.8
const SNEAK_MULT = 0.4
const MAX_SLOPE_ANGLE = 40
var vel = Vector3()
onready var camFP = self.get_parent().get_node("FP")
onready var camTP = self.get_parent().get_node("TP")
var MOUSE_SENSITIVITY = 0.2
var dir = Vector3() 
var play = false
var sprint = false
var sneak = false
var health = 100
var fall = 0
var spawnpoint = Vector3(0,80*2,0)
signal death

func _ready():
	set_physics_process(false)
	set_process_input(false)
	hide()
	pass

func _physics_process(delta):
	process_input(delta)
	process_movement(delta)
	process_damage()
	pass

func process_input(delta):
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
	
	if Input.is_action_pressed("game_sprint"):
		sprint = true
	else:
		sprint = false
	if Input.is_action_pressed("game_sneak"):
		sneak = true
	else:
		sneak = false
	
	
	dir.x = input_movement_vector.x
	dir.z = input_movement_vector.y
	
	if is_on_floor():
		if Input.is_action_pressed("game_jump"):
			vel.y = JUMP_SPEED
	
	# Capturing/Freeing the cursor
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func process_movement(delta):
	vel.y += GRAVITY * delta
	
	var speed_multiplier = 1
	if sneak:
		speed_multiplier = SNEAK_MULT
	elif sprint:
		speed_multiplier = SPRINT_MULT
	
	var a = deg2rad(self.rotation_degrees.y + 90)
	vel.z = -sin(a) * MAX_SPEED * dir.z * speed_multiplier
	vel.x = cos(a) * MAX_SPEED * dir.z * speed_multiplier
	
	a = deg2rad(self.rotation_degrees.y)
	vel.z += sin(a) * MAX_SPEED * dir.x * speed_multiplier
	vel.x += -cos(a) * MAX_SPEED * dir.x * speed_multiplier
	
	vel = move_and_slide(vel, Vector3(0,1,0), 0.05, 4, deg2rad(MAX_SLOPE_ANGLE))
	camFP.translation.x = self.translation.x
	camFP.translation.z = self.translation.z
	camFP.translation.y = self.translation.y
	
func process_damage():
	if play == true:
		#Fall Damage
		if vel.y < -22.5:
			fall = vel.y / 2
		if is_on_floor() and fall < -1:
			health -= round(-fall)
			fall = 0
		
		#-Y Damage
		if self.translation.y < 0:
			health -= 1
		
		#Death
		if health <= 0:
			emit_signal("death")
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			set_physics_process(false)
			play = false
			pass
		pass


func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		var t = camFP.get_transform()
		t.basis = Basis(t.basis.x.normalized(), deg2rad(-event.relative.y * MOUSE_SENSITIVITY))*t.basis
		camFP.set_transform(t)
		camFP.rotate_y(deg2rad(-event.relative.x * MOUSE_SENSITIVITY))
		
		
		var camera_rot = camFP.rotation_degrees
		#camera_rot.x = clamp(camera_rot.x, -70, 70)
		camFP.rotation_degrees = camera_rot
		
		self.rotation_degrees.y = camFP.rotation_degrees.y
	
	
func _process(delta):
	pass

func _on_UI_play():
	pass
	


func _on_BtnRespawn_pressed():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	self.set_translation(spawnpoint)
	vel = Vector3()
	health = 100
	fall = 0
	set_physics_process(true)
	set_process_input(true)
	play = true
	get_parent().get_node("UI/Player").show()


func _on_GridMap_worldready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	camFP.current = true
	camTP.current = false
	spawnpoint = get_parent().get_node("GridMap").worldspawn
	self.set_translation(spawnpoint)
	vel = Vector3()
	health = 100
	fall = 0
	set_physics_process(true)
	set_process_input(true)
	play = true