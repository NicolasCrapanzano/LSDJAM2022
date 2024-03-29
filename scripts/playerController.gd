extends KinematicBody

var mouse_sens = 0.05 #camera movement speed
var move_speed = 10 # player walking speed
var gravity = 20 # gravity strenght

var direction = Vector3()
var gravity_vec = Vector3()
var movement = Vector3()

var prevent_move = false
var step_rate = 0.5 #the speed at which step sound play

onready var head = get_node("%plHead")
onready var step_timer = get_node("%plStep_timer")
onready var audioStep = get_node("%plAudioStep")
onready var raycast = get_node("Spatial/plHead/raycast")

var main;

signal crossHairActive(active)
var isLookingInteractable = false
func _ready():
	main = get_tree().get_nodes_in_group("main")[0]
	main.setPlayer(self)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass # Replace with function body.

func _input(event):

	# prevent player movement (except escape)
	if (prevent_move):
		return;
		#interact with things
	if Input.is_action_just_pressed("interact"):
		if(isLookingInteractable):
			print("see object",raycast.get_collider())
		print("interact")
	
	# Camera movement
	if(event) is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sens))
		head.rotate_x(deg2rad(-event.relative.y * mouse_sens))
		head.rotation.x = clamp(head.rotation.x, deg2rad(-89), deg2rad(89))

func _process(delta):
	if raycast.is_colliding():
		##print("collide")
		if(!isLookingInteractable):
			isLookingInteractable = true
			emit_signal("crossHairActive",true)
	elif(isLookingInteractable):
		isLookingInteractable = false
		emit_signal("crossHairActive",false)

func _physics_process(delta):
	direction = Vector3()
	
	# prevent player movement
	if (prevent_move):
		return;
	
	#Gravity
	if not is_on_floor():
		gravity_vec += Vector3.DOWN * gravity * delta;
	else:
		gravity_vec = -get_floor_normal() * gravity
	
	#Player movement
	if (Input.is_action_pressed("move_forward")):
		direction -= transform.basis.z
	elif (Input.is_action_pressed("move_back")):
		direction += transform.basis.z
		
	if (Input.is_action_pressed("move_left")):
		direction -= transform.basis.x
	elif (Input.is_action_pressed("move_right")):
		direction += transform.basis.x
		
	if(direction != Vector3.ZERO):
		if(step_timer.time_left <= 0):
			audioStep.pitch_scale = rand_range(0.9,1.4)
			audioStep.play()
			step_timer.start(step_rate)
	
	direction = direction.normalized()
	var vel = direction * move_speed
	movement.z = vel.z  + gravity_vec.z
	movement.x = vel.x  + gravity_vec.x
	movement.y = gravity_vec.y
	
	move_and_slide(movement, Vector3.UP)
