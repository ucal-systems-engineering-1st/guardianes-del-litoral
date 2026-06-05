## foe_cannonball.gd
## Bala de cañón disparada por "El Armador Industrial".
## Usa CharacterBody2D + move_and_collide para detectar colisiones.
## Se destruye al impactar contra paredes o el jugador.
## Se dibuja proceduralmente (esfera negra con aura de brasas).

extends CharacterBody2D

## Velocidad del proyectil en píxeles/segundo
@export var speed: float = 280.0

## Tiempo máximo de vida del proyectil en segundos
@export var max_lifetime: float = 4.0

var direction: Vector2 = Vector2.ZERO
var _screen_size: Vector2
var _lifetime: float = 0.0

## Referencia al barco que disparó — se ignora para no colisionar con él
var shooter: CharacterBody2D = null


func _ready() -> void:
	_screen_size = get_viewport_rect().size
	# Ignora colisiones con el barco que nos disparó
	if shooter:
		add_collision_exception_with(shooter)


func _process(_delta: float) -> void:
	queue_redraw()


func _draw() -> void:
	# Aura exterior de brasas (naranja/rojo oscuro)
	draw_circle(Vector2.ZERO, 10.0, Color(0.7, 0.2, 0.05, 0.3))
	# Resplandor intermedio
	draw_circle(Vector2.ZERO, 7.0, Color(0.6, 0.15, 0.05, 0.5))
	# Núcleo de hierro negro
	draw_circle(Vector2.ZERO, 5.0, Color(0.08, 0.08, 0.08, 1.0))
	# Brillo metálico sutil
	draw_circle(Vector2(-1.5, -1.5), 1.8, Color(0.25, 0.25, 0.25, 0.6))


func _physics_process(delta: float) -> void:
	# Temporizador de vida — destruir si lleva demasiado tiempo viva
	_lifetime += delta
	if _lifetime >= max_lifetime:
		queue_free()
		return

	velocity = direction * speed
	var collision := move_and_collide(velocity * delta)

	if collision:
		var collider := collision.get_collider()

		# Si choca con el barco del jugador → daño + salpicadura + destruir
		if collider is CharacterBody2D and collider.name == "Ship":
			if collider.has_method("take_hit"):
				collider.take_hit()
			_spawn_splash()
			queue_free()
			return

		# Si choca con StaticBody2D (costa/bordes) → salpicadura + destruir
		if collider is StaticBody2D:
			_spawn_splash()
			queue_free()
			return

	# Destruir si sale del límite visible (margen de 100px)
	if position.x < -100 or position.x > _screen_size.x + 100 \
	or position.y < -100 or position.y > _screen_size.y + 100:
		queue_free()


func _spawn_splash() -> void:
	var splash_script := load("res://Scripts/Enemy/foe_splash_effect.gd")
	var splash := Node2D.new()
	splash.set_script(splash_script)
	get_parent().add_child(splash)
	splash.global_position = global_position
