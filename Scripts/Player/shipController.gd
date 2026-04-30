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

func _ready():
	target_position = global_position

func _physics_process(delta):
	var keyboard_dir = get_keyboard_direction()

	# 🎯 PRIORIDAD: teclado
	if keyboard_dir != Vector2.ZERO:
		using_mouse = false
		velocity = keyboard_dir * speed
	else:
		handle_mouse_input()
		move_to_target()

	move_and_slide()
	update_sprite()

# 🧠 INPUT TECLADO (estable)
func get_keyboard_direction() -> Vector2:
	var x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	var y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return Vector2(x, y).normalized()

# 🖱 INPUT MOUSE
func handle_mouse_input():
	if Input.is_action_just_pressed("mouse_left"):
		target_position = get_global_mouse_position()
		using_mouse = true

# 🚶 Movimiento mouse
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

	velocity = direction.normalized() * speed

# 🎯 SPRITES (8 direcciones)
func update_sprite():
	if velocity == Vector2.ZERO:
		return

	var dir = velocity.normalized()

	var x = sign(dir.x)
	var y = sign(dir.y)

	# Diagonales
	if x == 1 and y == -1:
		sprite.texture = tex_up_right
	elif x == -1 and y == -1:
		sprite.texture = tex_up_left
	elif x == 1 and y == 1:
		sprite.texture = tex_down_right
	elif x == -1 and y == 1:
		sprite.texture = tex_down_left
	
	# Cardinales
	elif x == 1:
		sprite.texture = tex_right
	elif x == -1:
		sprite.texture = tex_left
	elif y == 1:
		sprite.texture = tex_down
	elif y == -1:
		sprite.texture = tex_up
