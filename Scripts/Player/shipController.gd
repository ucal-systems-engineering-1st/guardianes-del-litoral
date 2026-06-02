extends CharacterBody2D

@export var speed: int = 100

@onready var sprite = $Sprite2D

# Cardinales
@export var tex_up: Texture2D
@export var tex_down: Texture2D
@export var tex_left: Texture2D
@export var tex_right: Texture2D

# Diagonales
@export var tex_up_right: Texture2D
@export var tex_up_left: Texture2D
@export var tex_down_right: Texture2D
@export var tex_down_left: Texture2D

var target_position: Vector2
var using_mouse := false

var input_direction: Vector2 = Vector2.ZERO
var last_direction: Vector2 = Vector2.DOWN

# Flotación
var float_time: float = 0.0
@export var float_amplitude: float = 3.0
@export var float_speed: float = 2.0
var base_position_y: float

func _ready():
	target_position = global_position
	base_position_y = sprite.position.y
	# Registra al barco en el grupo para que el enemigo pueda encontrarlo
	add_to_group("player_ship")

func _physics_process(delta):
	var keyboard_dir = get_keyboard_direction()

	if keyboard_dir != Vector2.ZERO:
		using_mouse = false
		input_direction = keyboard_dir
		velocity = keyboard_dir * speed
	else:
		handle_mouse_input()
		move_to_target()

	move_and_slide()
	update_sprite()
	update_float(delta)

# INPUT TECLADO
func get_keyboard_direction() -> Vector2:
	var x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	var y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return Vector2(x, y).normalized()

# INPUT MOUSE
func handle_mouse_input():
	if Input.is_action_just_pressed("mouse_left"):
		
		# IGNORA CLICKS EN UI
		if get_viewport().gui_get_hovered_control() != null:
			return
		
		target_position = get_global_mouse_position()
		using_mouse = true

# Movimiento mouse
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

# SPRITES (8 direcciones usando ángulo)
func update_sprite():
	var dir = input_direction

	if dir == Vector2.ZERO:
		dir = last_direction
	else:
		last_direction = dir

	dir = dir.normalized()

	var angle = atan2(dir.y, dir.x)
	var deg = rad_to_deg(angle)
	if deg < 0:
		deg += 360

	if deg >= 337.5 or deg < 22.5:
		sprite.texture = tex_right
	elif deg >= 22.5 and deg < 67.5:
		sprite.texture = tex_down_right
	elif deg >= 67.5 and deg < 112.5:
		sprite.texture = tex_down
	elif deg >= 112.5 and deg < 157.5:
		sprite.texture = tex_down_left
	elif deg >= 157.5 and deg < 202.5:
		sprite.texture = tex_left
	elif deg >= 202.5 and deg < 247.5:
		sprite.texture = tex_up_left
	elif deg >= 247.5 and deg < 292.5:
		sprite.texture = tex_up
	elif deg >= 292.5 and deg < 337.5:
		sprite.texture = tex_up_right

# FLOTACIÓN
func update_float(delta: float):
	float_time += delta
	sprite.position.y = base_position_y + sin(float_time * float_speed) * float_amplitude


# IMPACTO — llamado por foe_projectile al colisionar
func take_hit() -> void:
	# Flash rojo como feedback visual de impacto
	var tween := create_tween()
	tween.tween_property(sprite, "modulate", Color(1.0, 0.15, 0.15, 1.0), 0.08)
	tween.tween_property(sprite, "modulate", Color(1.0, 1.0, 1.0, 1.0), 0.25)
	print("[Ship] ¡Impactado por el Armador Industrial!")
