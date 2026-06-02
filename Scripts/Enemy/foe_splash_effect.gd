## foe_splash_effect.gd
## Efecto procedural de salpicadura de residuo tóxico.
## Dibuja burbujas de aceite que se expanden y desvanecen en el mar.

extends Node2D

var color: Color = Color(0.1, 0.45, 0.1, 0.75) # Verde petróleo tóxico
var max_radius: float = 24.0
var duration: float = 0.5
var _radius: float = 2.0
var _alpha: float = 0.75

func _ready() -> void:
	# Transición de expansión de radio
	var tween_rad := create_tween()
	tween_rad.tween_property(self, "_radius", max_radius, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	
	# Transición de desvanecimiento
	var tween_alpha := create_tween()
	tween_alpha.tween_property(self, "_alpha", 0.0, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	
	# Eliminación automática al finalizar el efecto
	tween_rad.finished.connect(queue_free)


func _process(_delta: float) -> void:
	queue_redraw()


func _draw() -> void:
	var draw_color := color
	draw_color.a = _alpha
	
	# Burbuja central
	draw_circle(Vector2.ZERO, _radius, draw_color)
	
	# Gotas periféricas que se expanden proporcionalmente
	draw_circle(Vector2(-_radius * 0.6, -_radius * 0.4), _radius * 0.22, draw_color)
	draw_circle(Vector2(_radius * 0.5, _radius * 0.5), _radius * 0.16, draw_color)
	draw_circle(Vector2(-_radius * 0.2, _radius * 0.7), _radius * 0.25, draw_color)
	draw_circle(Vector2(_radius * 0.7, -_radius * 0.3), _radius * 0.18, draw_color)
