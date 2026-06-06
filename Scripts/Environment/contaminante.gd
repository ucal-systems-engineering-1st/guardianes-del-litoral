extends Area2D

# ─── PARÁMETROS (entrada del diseñador) ─────────────────────────────────────
## Velocidad de giro angular hacia la zona objetivo (rad/s)
@export var turn_speed: float = 1.2
## Velocidad de desplazamiento lineal (px/s)
@export var move_speed: float = 25.0
## Distancia a la que se considera que llegó al objetivo (px)
@export var alcance_deteccion: float = 35.0

# ─── ESTADO (calculado en tiempo de ejecución) ───────────────────────────────
var zona_objetivo: Vector2 = Vector2.ZERO   # posición de la zona vulnerable
var angulo_objetivo: float = 0.0            # ángulo hacia el objetivo (rad)
var distancia_objetivo: float = 0.0         # distancia actual al objetivo (px)
var velocidad_actual: Vector2 = Vector2.ZERO
var activo: bool = false

# ─── RESULTADO ───────────────────────────────────────────────────────────────
signal contaminante_llego       # emitido cuando alcanza la zona vulnerable
signal contaminante_limpiado    # emitido cuando el barco lo intercepta


func iniciar(target_pos: Vector2) -> void:
	zona_objetivo = target_pos
	activo = true


func _process(delta: float) -> void:
	if not activo:
		return

	var direccion = zona_objetivo - global_position
	distancia_objetivo = direccion.length()

	if distancia_objetivo < alcance_deteccion:
		activo = false
		emit_signal("contaminante_llego")
		queue_free()
		return

	# Corrección angular: calcula el ángulo hacia el objetivo y gira
	# suavemente usando lerp_angle para evitar giros bruscos.
	angulo_objetivo = direccion.angle()
	rotation = lerp_angle(rotation, angulo_objetivo, turn_speed * delta)

	# Avanza en la dirección actual de rotación
	velocidad_actual = Vector2.RIGHT.rotated(rotation) * move_speed
	global_position += velocidad_actual * delta


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Ship" and activo:
		activo = false
		emit_signal("contaminante_limpiado")
		queue_free()
