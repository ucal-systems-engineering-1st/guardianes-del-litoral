extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D
@onready var path_follow: PathFollow2D = get_parent()

@export var velocidad_min := 60.0
@export var velocidad_max := 120.0

@export var aleteo_min := 0.8
@export var aleteo_max := 1.3

var speed: float
var ultima_posicion: Vector2
var puede_volar := false

func _ready():
	add_to_group("gaviotas")

	# Velocidad de vuelo aleatoria
	speed = randf_range(velocidad_min, velocidad_max)

	# Velocidad de la animación aleatoria
	sprite.speed_scale = randf_range(aleteo_min, aleteo_max)

	sprite.play("flying")

	ultima_posicion = path_follow.global_position

func _physics_process(delta):
	if !puede_volar:
		return

	path_follow.progress += speed * delta

	var dir = path_follow.global_position - ultima_posicion

	# Girar hacia donde vuela
	if abs(dir.x) > 0.1:
		sprite.flip_h = dir.x < 0

	ultima_posicion = path_follow.global_position
