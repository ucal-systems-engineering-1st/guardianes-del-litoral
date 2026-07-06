extends CharacterBody2D

## Señales del sistema de vida
signal health_changed(value: int)
signal ship_destroyed()

@export var speed: int = 100

@onready var sprite = $Sprite2D
@onready var health_bar = $HealthBar

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

# Ralentización por daño de residuo tóxico
var _slow_timer: float = 0.0
var _slow_factor: float = 1.0

# Sistema de vida (8 golpes = muerte)
@export var max_health: int = 8
var current_health: int = 8
var _is_dead: bool = false


func _ready():
	target_position = global_position
	base_position_y = sprite.position.y
	# Registra al barco en el grupo para que el enemigo pueda encontrarlo
	add_to_group("player_ship")
	_update_health_bar()


func _physics_process(delta):
	# Actualiza el temporizador de ralentización
	if _slow_timer > 0.0:
		_slow_timer -= delta
		if _slow_timer <= 0.0:
			_slow_factor = 1.0

	var keyboard_dir = get_keyboard_direction()

	if keyboard_dir != Vector2.ZERO:
		using_mouse = false
		input_direction = keyboard_dir
		velocity = keyboard_dir * speed * _slow_factor
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
	velocity = input_direction * speed * _slow_factor

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
	# Guard: si el barco ya está destruido, ignorar
	if _is_dead:
		return

	# Descontar vida
	current_health -= 1
	_update_health_bar()
	emit_signal("health_changed", current_health)

	# Flash rojo como feedback visual de impacto
	var tween := create_tween()
	tween.tween_property(sprite, "modulate", Color(1.0, 0.15, 0.15, 1.0), 0.08)
	tween.tween_property(sprite, "modulate", Color(1.0, 1.0, 1.0, 1.0), 0.25)

	# Ralentiza la velocidad al 60% (40% de reducción) durante 1.5s
	_slow_factor = 0.6
	_slow_timer = 1.5

	# Efecto de astillas de madera (coordenadas polares → cartesianas)
	_spawn_hit_effect()

	print("[Ship] ¡Impactado! Vida restante: %d/%d" % [current_health, max_health])

	# ¿Barco destruido?
	if current_health <= 0:
		_is_dead = true
		_trigger_death_sequence()


# Maneja la secuencia de muerte: detiene el barco, apaga colisiones, oculta barra e inicia hundimiento y explosión
func _trigger_death_sequence() -> void:
	# 1. Detener movimiento y apagar colisiones para no recibir más golpes
	velocity = Vector2.ZERO
	collision_layer = 0
	collision_mask = 0

	# 2. Ocultar la barra de salud flotante
	if health_bar:
		health_bar.visible = false

	# 3. Iniciar animación de hundimiento e inclinación del barco (Tween paralelo)
	var sink_tween := create_tween().set_parallel(true)
	var tilt_direction := 1.0 if randf() > 0.5 else -1.0

	# Inclinación lateral (escorar)
	sink_tween.tween_property(sprite, "rotation", 0.38 * tilt_direction, 1.1)\
		.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

	# Hundimiento en Y (hacia el fondo del mar)
	sink_tween.tween_property(sprite, "position:y", sprite.position.y + 60.0, 1.1)\
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)

	# Carbonizado y desvanecimiento final (se oscurece y se vuelve transparente)
	sink_tween.tween_property(sprite, "modulate", Color(0.18, 0.18, 0.18, 0.0), 1.1)\
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)

	# 4. Instanciar la explosión procedural principal en nuestra posición (solapada)
	var explosion := Node2D.new()
	explosion.set_script(load("res://Scripts/Player/ship_explosion_effect.gd"))
	get_parent().add_child(explosion)
	explosion.global_position = global_position

	print("[Ship] Secuencia de hundimiento y explosión iniciada...")

	# 5. Esperar 1.2 segundos para que termine el hundimiento antes de abrir el modal
	await get_tree().create_timer(1.2).timeout
	emit_signal("ship_destroyed")



# Actualiza el valor y la opacidad (transparencia) de la barra de vida
func _update_health_bar() -> void:
	if health_bar:
		health_bar.value = current_health
		var ratio := float(current_health) / float(max_health)
		# Se desvanece (más transparente) conforme baja la vida
		health_bar.modulate.a = lerp(0.25, 1.0, ratio)


# Instancia el efecto visual de astillas en el punto de impacto
func _spawn_hit_effect() -> void:
	var effect := Node2D.new()
	effect.set_script(load("res://Scripts/Player/ship_hit_effect.gd"))
	get_parent().add_child(effect)
	effect.global_position = global_position
