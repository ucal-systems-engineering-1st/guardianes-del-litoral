extends CharacterBody2D

@export var speed: float = 60.0
@export var distancia_deteccion: float = 120.0
@export var distancia_parada: float = 20.0
@export var animation_fps: float = 6.0

const FRAMES := 4

enum Direction {
	DOWN = 0,
	RIGHT = 1,
	LEFT = 2,
	UP = 3
}

var _valentina: CharacterBody2D

var current_frame := 0
var current_direction := Direction.DOWN
var animation_timer := 0.0

@onready var sprite: Sprite2D = $Sprite2D


func _ready() -> void:

	sprite.hframes = 4
	sprite.vframes = 4

	_valentina = get_parent().get_node_or_null("Valentina")

	sprite.frame_coords = Vector2i(0, Direction.DOWN)


func _physics_process(delta: float) -> void:

	if _valentina == null:
		return

	var distancia := global_position.distance_to(
		_valentina.global_position
	)

	if distancia <= distancia_deteccion:

		if distancia > distancia_parada:

			var dir := (
				_valentina.global_position - global_position
			).normalized()

			velocity = dir * speed

		else:

			velocity = Vector2.ZERO

	else:

		velocity = Vector2.ZERO

	move_and_slide()

	update_direction()
	update_animation(delta)


func update_direction() -> void:

	if velocity.length() < 1.0:
		return

	var dx := velocity.x
	var dy := velocity.y

	# Prioriza vertical para evitar giros raros
	if abs(dy) > abs(dx):

		if dy > 0:
			current_direction = Direction.DOWN
		else:
			current_direction = Direction.UP

	else:

		if dx > 0:
			current_direction = Direction.RIGHT
		else:
			current_direction = Direction.LEFT


func update_animation(delta: float) -> void:

	if velocity.length() > 1.0:

		animation_timer += delta

		if animation_timer >= 1.0 / animation_fps:

			animation_timer = 0.0
			current_frame = (current_frame + 1) % FRAMES

	else:

		current_frame = 0

	sprite.frame_coords = Vector2i(
		current_frame,
		current_direction
	)
