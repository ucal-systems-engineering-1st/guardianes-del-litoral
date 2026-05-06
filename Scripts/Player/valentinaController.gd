extends CharacterBody2D

@export var speed: int = 100
@onready var sprite: Sprite2D = $Sprite2D

var input_direction: Vector2 = Vector2.ZERO
var last_direction: Vector2 = Vector2.DOWN

var target_position: Vector2
var using_mouse := false

# Animación del spritesheet
const FRAMES_PER_ANIMATION: int = 4
@export var animation_fps: float = 8.0
var animation_timer: float = 0.0
var current_frame: int = 0

enum Direction { DOWN = 0, LEFT = 1, RIGHT = 2, UP = 3 }
var current_direction: int = Direction.DOWN


func _ready():
	target_position = global_position
	sprite.hframes = 4
	sprite.vframes = 4
	sprite.frame = 0


func _physics_process(delta: float):
	var keyboard_dir = get_keyboard_direction()

	if keyboard_dir != Vector2.ZERO:
		using_mouse = false
		input_direction = keyboard_dir
		velocity = keyboard_dir * speed
	else:
		handle_mouse_input()
		move_to_target()

	move_and_slide()
	update_direction()
	update_animation(delta)

func get_keyboard_direction() -> Vector2:
	var x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	var y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return Vector2(x, y).normalized()

func handle_mouse_input():
	if Input.is_action_just_pressed("mouse_left"):
		target_position = get_global_mouse_position()
		using_mouse = true

func move_to_target():
	if not using_mouse:
		velocity = Vector2.ZERO
		return

	var direction = target_position - global_position
	var distance = direction.length()

	if distance < 5:
		using_mouse = false
		velocity = Vector2.ZERO
		return

	input_direction = direction.normalized()
	velocity = input_direction * speed

func update_direction():
	var dir = input_direction

	if dir == Vector2.ZERO:
		dir = last_direction
	else:
		last_direction = dir

	if abs(dir.x) > abs(dir.y):
		# Movimiento principalmente horizontal
		if dir.x > 0:
			current_direction = Direction.RIGHT
		else:
			current_direction = Direction.LEFT
	else:
		# Movimiento principalmente vertical
		if dir.y > 0:
			current_direction = Direction.DOWN
		else:
			current_direction = Direction.UP

func update_animation(delta: float):
	var is_moving = velocity.length() > 0.1

	if is_moving:
		animation_timer += delta
		var frame_duration = 1.0 / animation_fps

		if animation_timer >= frame_duration:
			animation_timer -= frame_duration
			current_frame = (current_frame + 1) % FRAMES_PER_ANIMATION
	else:
		animation_timer = 0.0
		current_frame = 0

	sprite.frame_coords = Vector2i(current_frame, current_direction)
