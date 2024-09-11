extends CharacterBody3D

var mouse_sensitivity := 0.001
var twist_input := 0.0
var pitch_input := 0.0
var jump_input := 20.0
var speed := 100

@export var gravity := 400.0

@onready var twist_pivot := $TwistPivot
@onready var pitch_pivot := $TwistPivot/PitchPivot

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	movement_controller(delta)
	if (is_game_focused() == false): return
	menu_controller()
	
func is_game_focused() -> bool:
	return Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
		
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if is_game_focused():
			twist_input = - event.relative.x * mouse_sensitivity
			pitch_input = - event.relative.y * mouse_sensitivity

func menu_controller() -> void:
	# add logic for showing UI
	if (Input.is_action_just_pressed("ui_cancel") and is_game_focused() == true):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	elif (Input.is_action_just_pressed("ui_cancel") and is_game_focused() == false):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func movement_controller(delta: float) -> void:
	var input := Vector3.ZERO
	
	input.x = Input.get_axis("move_left", "move_right")
	input.z = Input.get_axis("move_forward", "move_backward")
	
	if (Input.is_action_just_pressed("jump")): input.y = jump_input
		
	velocity = twist_pivot.basis * input.normalized() * speed * delta
	
	# keep the player on the ground
	if (is_on_floor() == false): velocity.y -= gravity * delta
		
	move_and_slide()
		
	twist_pivot.rotate_y(twist_input)
	#pitch_pivot.rotate_x(pitch_input)
	#pitch_pivot.rotation.x = clamp(pitch_pivot.rotation.x, 
		#deg_to_rad(-45), 
		#deg_to_rad(-35)
	#)
	
	twist_input = 0.0
	pitch_input = 0.0
