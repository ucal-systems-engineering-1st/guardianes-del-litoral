## ship_hit_effect.gd
## Efecto visual de impacto en el Ship del jugador.
## Genera astillas de madera que salen disparadas desde el punto de golpe.
##
## Las posiciones de cada astilla se calculan con coordenadas polares → cartesianas:
##   x = r · cos(θ)   y = r · sin(θ)
## donde θ es el ángulo de salida (distribuido uniformemente) y r la distancia recorrida.

extends Node2D

# ── Configuración de astillas ─────────────────────────────────────────────────
const SPLINTER_COUNT := 10          # Número de trozos de madera
const MAX_DIST       := 40.0        # Distancia máxima de vuelo (en px)
const DURATION       := 0.55        # Duración de la animación en segundos

# Colores de madera (café oscuro, café medio, tostado)
const WOOD_COLORS := [
	Color(0.36, 0.20, 0.08, 1.0),
	Color(0.50, 0.29, 0.11, 1.0),
	Color(0.62, 0.38, 0.16, 1.0),
	Color(0.44, 0.25, 0.09, 1.0),
]

# Estado de cada astilla: posición actual, ángulo de rotación, tamaño, color
var _splinters: Array = []

# Progreso de la animación [0.0 → 1.0], animado por Tween
var _progress: float = 0.0
var _alpha: float = 1.0


func _ready() -> void:
	_init_splinters()

	var tween := create_tween().set_parallel(true)

	# Avance del progreso (controla la distancia de vuelo vía r = progress * MAX_DIST)
	tween.tween_property(self, "_progress", 1.0, DURATION)\
		.set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)

	# Desvanecimiento (la última mitad del tiempo)
	tween.tween_property(self, "_alpha", 0.0, DURATION * 0.55)\
		.set_delay(DURATION * 0.45)\
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)

	# Auto-destruir al terminar
	tween.chain().tween_callback(queue_free)


func _process(_delta: float) -> void:
	queue_redraw()


## Inicializa cada astilla con ángulo y tamaño aleatorios
func _init_splinters() -> void:
	var rng := RandomNumberGenerator.new()
	rng.randomize()

	for i in range(SPLINTER_COUNT):
		# θ distribuido uniformemente más un desvío aleatorio para que no sea tan uniforme
		var base_angle := (TAU / SPLINTER_COUNT) * i
		var jitter     := rng.randf_range(-0.35, 0.35)  # ± variación natural
		var theta      := base_angle + jitter

		_splinters.append({
			"theta":    theta,
			"rotation": rng.randf_range(0.0, TAU),          # rotación propia del trozo
			"width":    rng.randf_range(3.0, 7.0),           # ancho del trozo
			"height":   rng.randf_range(6.0, 14.0),          # largo del trozo (astilla)
			"color_idx": rng.randi_range(0, WOOD_COLORS.size() - 1),
		})


func _draw() -> void:
	for splinter in _splinters:
		var theta: float = splinter["theta"]

		# ── Conversión Polar → Cartesiana ─────────────────────────────────────
		# r crece conforme avanza el progreso (EASE_OUT: rápido al inicio, frena)
		var r: float = _progress * MAX_DIST
		var pos := Vector2(r * cos(theta), r * sin(theta))
		# ─────────────────────────────────────────────────────────────────────

		# Rotación propia de la astilla (gira mientras vuela)
		var angle: float = splinter["rotation"] + _progress * TAU * 1.5

		var w: float = splinter["width"]
		var h: float = splinter["height"]

		# Vértices del rectángulo (astilla) centrado en el origen local
		var half_w := w * 0.5
		var half_h := h * 0.5
		var verts := PackedVector2Array([
			Vector2(-half_w, -half_h),
			Vector2( half_w, -half_h),
			Vector2( half_w,  half_h),
			Vector2(-half_w,  half_h),
		])

		# Rotar los vértices alrededor del centro de la astilla
		for j in range(verts.size()):
			verts[j] = verts[j].rotated(angle) + pos

		# Dibujar con alpha animado
		var c: Color = WOOD_COLORS[splinter["color_idx"]]
		c.a = _alpha
		draw_polygon(verts, PackedColorArray([c, c, c, c]))
