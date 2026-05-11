extends CharacterBody2D

@export var speed: int = 100

@onready var sprite: Sprite2D = $Sprite2D


var input_direction: Vector2 = Vector2.ZERO
var last_direction: Vector2 = Vector2.DOWN


# Animación del spritesheet
const FRAMES_PER_ANIMATION: int = 4

@export var animation_fps: float = 8.0

var animation_timer: float = 0.0
var current_frame: int = 0


enum Direction {
	DOWN = 0,
	LEFT = 1,
	RIGHT = 2,
	UP = 3
}

var current_direction: int = Direction.DOWN


func _ready():
	sprite.hframes = 4
	sprite.vframes = 4
	sprite.frame = 0


func _physics_process(delta: float):

	if get_tree().paused:
		velocity = Vector2.ZERO
		move_and_slide()
		return

	var keyboard_dir = get_keyboard_direction()

	input_direction = keyboard_dir
	velocity = keyboard_dir * speed

	move_and_slide()

	update_direction()
	update_animation(delta)


func get_keyboard_direction() -> Vector2:

	var x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))

	var y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))

	return Vector2(x, y).normalized()


func update_direction():

	var dir = input_direction

	if dir == Vector2.ZERO:
		dir = last_direction
	else:
		last_direction = dir

	if abs(dir.x) > abs(dir.y):

		if dir.x > 0:
			current_direction = Direction.RIGHT
		else:
			current_direction = Direction.LEFT

	else:

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

	sprite.frame_coords = Vector2i(
		current_frame,
		current_direction
	)
