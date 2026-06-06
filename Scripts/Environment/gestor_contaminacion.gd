extends Node

# ─── PARÁMETROS ──────────────────────────────────────────────────────────────
@export var contaminante_scene: PackedScene
## Segundos entre cada aparición de contaminante
@export var intervalo_spawn: float = 6.0
## Máximo de contaminantes simultáneos en pantalla
@export var max_contaminantes: int = 4

# Posiciones de spawn (bordes del mar, alejadas de las zonas)
const SPAWN_POSITIONS: Array = [
	Vector2(80, 300),
	Vector2(80, 500),
	Vector2(300, 80),
	Vector2(500, 80),
	Vector2(580, 620),
]

# ─── RESULTADO (acumulado durante la sesión) ─────────────────────────────────
var contaminantes_totales: int = 0
var contaminantes_limpiados: int = 0
var hit_rate: float = 0.0   # ratio limpiados / totales  [0.0 – 1.0]

# ─── ESTADO INTERNO ──────────────────────────────────────────────────────────
var _timer: float = 0.0
var _contaminantes_activos: int = 0

signal hit_rate_actualizado(nuevo_hit_rate: float)


func _process(delta: float) -> void:
	if not contaminante_scene:
		return

	_timer += delta
	if _timer >= intervalo_spawn and _contaminantes_activos < max_contaminantes:
		_timer = 0.0
		_spawn_contaminante()


func _spawn_contaminante() -> void:
	var zona_pos = _zona_vulnerable_aleatoria()
	if zona_pos == Vector2.ZERO:
		return

	var c: Area2D = contaminante_scene.instantiate()
	c.global_position = _posicion_spawn_aleatoria()
	get_parent().add_child(c)
	c.iniciar(zona_pos)

	_contaminantes_activos += 1
	contaminantes_totales += 1

	c.connect("contaminante_limpiado", _on_limpiado)
	c.connect("contaminante_llego", _on_llego)


func _on_limpiado() -> void:
	_contaminantes_activos -= 1
	contaminantes_limpiados += 1
	_recalcular_hit_rate()


func _on_llego() -> void:
	_contaminantes_activos -= 1
	_recalcular_hit_rate()


func _recalcular_hit_rate() -> void:
	if contaminantes_totales > 0:
		hit_rate = float(contaminantes_limpiados) / float(contaminantes_totales)
		emit_signal("hit_rate_actualizado", hit_rate)


func _posicion_spawn_aleatoria() -> Vector2:
	return SPAWN_POSITIONS[randi() % SPAWN_POSITIONS.size()]


func _zona_vulnerable_aleatoria() -> Vector2:
	var zonas = get_tree().get_nodes_in_group("zonas_vulnerables")
	if zonas.is_empty():
		return Vector2.ZERO
	var zona = zonas[randi() % zonas.size()]
	return zona.global_position


func obtener_resumen() -> Dictionary:
	return {
		"totales": contaminantes_totales,
		"limpiados": contaminantes_limpiados,
		"hit_rate": hit_rate,
	}
