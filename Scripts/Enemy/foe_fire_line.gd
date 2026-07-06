## foe_fire_line.gd
## Línea de trayectoria efímera que indica la dirección del disparo enemigo.
## Se dibuja proceduralmente como segmentos punteados y se desvanece rápidamente.

extends Node2D

## Dirección del disparo (se normaliza internamente)
var fire_direction: Vector2 = Vector2.RIGHT

## Longitud total de la línea en píxeles
var line_length: float = 120.0

## Duración del efecto en segundos
var duration: float = 0.35

var _alpha: float = 0.7


func _ready() -> void:
	fire_direction = fire_direction.normalized()

	# Desvanecimiento de la línea
	var tween := create_tween()
	tween.tween_property(self, "_alpha", 0.0, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.finished.connect(queue_free)


func _process(_delta: float) -> void:
	queue_redraw()


func _draw() -> void:
	var color := Color(0.85, 0.25, 0.1, _alpha) # Naranja/rojo oscuro industrial
	var dash_length: float = 8.0
	var gap_length: float = 6.0
	var total: float = 0.0
	var start: Vector2 = Vector2.ZERO

	# Dibuja segmentos punteados a lo largo de la dirección de disparo
	while total < line_length:
		var end_dist: float = min(total + dash_length, line_length)
		var p1: Vector2 = start + fire_direction * total
		var p2: Vector2 = start + fire_direction * end_dist
		draw_line(p1, p2, color, 2.0)
		total = end_dist + gap_length
