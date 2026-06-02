## foe_ship_controller.gd
## Controlador del barco enemigo "El Armador Industrial".
## Patrulla el mar automáticamente mediante waypoints, apunta sus sprites
## hacia la dirección de movimiento (8 direcciones, mismo sistema que shipController),
## y dispara proyectiles tóxicos periódicamente hacia el barco del jugador.

extends CharacterBody2D

# ---------------------------------------------------------------------------
# CONFIGURACIÓN EXPORTADA
# ---------------------------------------------------------------------------

## Velocidad de patrullaje automático
@export var patrol_speed: float = 60.0

## Tiempo en segundos entre disparos
@export var fire_rate: float = 3.5

## Distancia de detección para iniciar modo ataque
@export var detection_range: float = 380.0

## Amplitud del efecto de flotación
@export var float_amplitude: float = 2.5

## Velocidad del efecto de flotación
@export var float_speed: float = 1.8

# Texturas por dirección (8 direcciones)
@export var tex_up: Texture2D
@export var tex_down: Texture2D
@export var tex_left: Texture2D
@export var tex_right: Texture2D
@export var tex_up_right: Texture2D
@export var tex_up_left: Texture2D
@export var tex_down_right: Texture2D
@export var tex_down_left: Texture2D

# ---------------------------------------------------------------------------
# REFERENCIAS INTERNAS
# ---------------------------------------------------------------------------

@onready var sprite: Sprite2D = $Sprite2D

## Escena del proyectil a instanciar
var projectile_scene: PackedScene

## Referencia al barco del jugador (se busca automáticamente)
var _player_ship: Node2D

## Waypoints de patrullaje: recorre el mar siguiendo estos puntos
var _waypoints: Array[Vector2] = []
var _current_waypoint: int = 0
var _patrol_clockwise: bool = true

var _input_direction: Vector2 = Vector2.ZERO
var _last_direction: Vector2 = Vector2.RIGHT

# Flotación
var _float_time: float = 0.0
var _base_position_y: float

# Cooldown de disparo
var _fire_timer: float = 0.0

# ---------------------------------------------------------------------------
# CICLO DE VIDA
# ---------------------------------------------------------------------------

func _ready() -> void:
	_base_position_y = sprite.position.y

	# Carga el proyectil desde su escena
	projectile_scene = load("res://Scenes/Enemy/foe_projectile.tscn")

	# Busca el barco del jugador en el árbol de la escena
	_player_ship = get_tree().get_first_node_in_group("player_ship")

	# Generamos una ruta elíptica dinámica en mar abierto para evitar colisiones
	# Centro en mar abierto, radios que previenen tocar la costa (X < 750)
	var center := Vector2(450.0, 400.0)
	var rx := 280.0
	var ry := 220.0
	var steps := 12
	for i in range(steps):
		var angle := (TAU / steps) * i
		var wp := center + Vector2(cos(angle) * rx, sin(angle) * ry)
		_waypoints.append(wp)


func _physics_process(delta: float) -> void:
	_patrol(delta)
	_update_sprite()
	_update_float(delta)
	_handle_shooting(delta)
	move_and_slide()


# ---------------------------------------------------------------------------
# PATRULLAJE POR WAYPOINTS
# ---------------------------------------------------------------------------

func _patrol(delta: float) -> void:
	if _waypoints.is_empty():
		return

	var target: Vector2 = _waypoints[_current_waypoint]
	var direction: Vector2 = (target - global_position)
	var distance: float = direction.length()

	if distance < 8.0:
		if _patrol_clockwise:
			_current_waypoint = (_current_waypoint + 1) % _waypoints.size()
		else:
			_current_waypoint = (_current_waypoint - 1 + _waypoints.size()) % _waypoints.size()
		
		# Al completar una órbita (regresa al waypoint 0), hay 50% de probabilidad de revertir sentido
		if _current_waypoint == 0:
			if randf() < 0.5:
				_patrol_clockwise = not _patrol_clockwise
		return

	_input_direction = direction.normalized()
	velocity = _input_direction * patrol_speed


# ---------------------------------------------------------------------------
# SISTEMA DE DISPARO
# ---------------------------------------------------------------------------

func _handle_shooting(delta: float) -> void:
	_fire_timer -= delta

	# Solo dispara si el jugador existe y está dentro del rango de detección
	if _player_ship == null:
		_player_ship = get_tree().get_first_node_in_group("player_ship")
		return

	var dist: float = global_position.distance_to(_player_ship.global_position)

	if dist <= detection_range and _fire_timer <= 0.0:
		_fire_toward(_player_ship.global_position)
		_fire_timer = fire_rate


func _fire_toward(target_pos: Vector2) -> void:
	if projectile_scene == null:
		return

	var projectile: Area2D = projectile_scene.instantiate()
	projectile.direction = (target_pos - global_position).normalized()

	# Spawna el proyectil en la escena padre para que no herede transformaciones
	get_parent().add_child(projectile)
	projectile.global_position = global_position


# ---------------------------------------------------------------------------
# SPRITES 8 DIRECCIONES (mismo algoritmo que shipController.gd)
# ---------------------------------------------------------------------------

func _update_sprite() -> void:
	var dir: Vector2 = _input_direction

	if dir == Vector2.ZERO:
		dir = _last_direction
	else:
		_last_direction = dir

	dir = dir.normalized()

	var angle: float = atan2(dir.y, dir.x)
	var deg: float   = rad_to_deg(angle)
	if deg < 0:
		deg += 360.0

	if   deg >= 337.5 or  deg <  22.5: sprite.texture = tex_right
	elif deg >=  22.5 and deg <  67.5: sprite.texture = tex_down_right
	elif deg >=  67.5 and deg < 112.5: sprite.texture = tex_down
	elif deg >= 112.5 and deg < 157.5: sprite.texture = tex_down_left
	elif deg >= 157.5 and deg < 202.5: sprite.texture = tex_left
	elif deg >= 202.5 and deg < 247.5: sprite.texture = tex_up_left
	elif deg >= 247.5 and deg < 292.5: sprite.texture = tex_up
	elif deg >= 292.5 and deg < 337.5: sprite.texture = tex_up_right


# ---------------------------------------------------------------------------
# FLOTACIÓN
# ---------------------------------------------------------------------------

func _update_float(delta: float) -> void:
	_float_time += delta
	sprite.position.y = _base_position_y + sin(_float_time * float_speed) * float_amplitude
