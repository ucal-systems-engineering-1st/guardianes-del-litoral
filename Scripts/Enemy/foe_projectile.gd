## foe_projectile.gd
## Proyectil disparado por el barco enemigo (El Armador Industrial).
## Se mueve en línea recta a alta velocidad y destruye al salir del viewport.

extends Area2D

## Velocidad del proyectil en píxeles/segundo
@export var speed: float = 280.0

var direction: Vector2 = Vector2.ZERO
var _screen_size: Vector2

func _ready() -> void:
	_screen_size = get_viewport_rect().size
	body_entered.connect(_on_body_entered)

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

	# Destruir si sale del límite visible (con margen de 100px)
	if position.x < -100 or position.x > _screen_size.x + 100 \
	or position.y < -100 or position.y > _screen_size.y + 100:
		queue_free()

func _on_body_entered(body: Node) -> void:
	if body.name == "Ship":
		# Notifica al barco aliado que fue impactado
		body.take_hit()
		queue_free()
