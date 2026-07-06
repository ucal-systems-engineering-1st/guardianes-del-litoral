## ship_explosion_effect.gd
## Efecto de estallido y hundimiento procedural para el barco del jugador.
## Genera una onda de choque en el agua, nubes de fuego, humo y una ráfaga masiva de astillas de madera.

extends Node2D

# ── Configuración de partículas y animación ──────────────────────────────────
const ASTILLAS_COUNT := 20
const CLOUDS_COUNT   := 8
const DURATION       := 1.1

# Colores del fuego y humo
const FIRE_COLORS := [
	Color(1.0, 0.25, 0.05, 0.95),  # Rojo/naranja intenso
	Color(1.0, 0.55, 0.0, 0.95),   # Naranja brillante
	Color(1.0, 0.85, 0.1, 0.95),   # Amarillo fuego
]

const SMOKE_COLORS := [
	Color(0.18, 0.18, 0.18, 0.85), # Gris muy oscuro
	Color(0.32, 0.32, 0.32, 0.80), # Gris ceniza
	Color(0.48, 0.48, 0.48, 0.70), # Gris claro disperso
]

# Colores de madera (astillas)
const WOOD_COLORS := [
	Color(0.36, 0.20, 0.08, 1.0),
	Color(0.50, 0.29, 0.11, 1.0),
	Color(0.62, 0.38, 0.16, 1.0),
]

# ── Datos de la animación ─────────────────────────────────────────────────────
var _splinters: Array = []
var _clouds: Array    = []

# Variables controladas por Tween
var _progress: float     = 0.0  # Controla distancia de astillas
var _fire_radius: float  = 0.0  # Radio de expansión del fuego
var _smoke_radius: float = 0.0  # Radio de expansión del humo
var _wave_radius: float  = 0.0  # Radio de la onda de agua
var _alpha: float        = 1.0  # Desvanecimiento general


func _ready() -> void:
	_init_effect_elements()

	var tween := create_tween().set_parallel(true)

	# 1. Onda de agua expandiéndose rápido
	tween.tween_property(self, "_wave_radius", 90.0, DURATION * 0.55)\
		.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

	# 2. Esferas de fuego (estallido instantáneo que se reduce/apaga rápido)
	tween.tween_property(self, "_fire_radius", 45.0, DURATION * 0.40)\
		.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

	# 3. Nubes de humo (se expanden lento y cubren la zona)
	tween.tween_property(self, "_smoke_radius", 65.0, DURATION * 0.80)\
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

	# 4. Dispersión de las astillas de madera (polar → cartesiana)
	tween.tween_property(self, "_progress", 1.0, DURATION * 0.90)\
		.set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)

	# 5. Desvanecimiento de todo el efecto al final
	tween.tween_property(self, "_alpha", 0.0, DURATION * 0.45)\
		.set_delay(DURATION * 0.55)\
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)

	# Auto-destrucción
	tween.chain().tween_callback(queue_free)


func _process(_delta: float) -> void:
	queue_redraw()


## Inicializa los parámetros de las astillas y nubes de la explosión
func _init_effect_elements() -> void:
	var rng := RandomNumberGenerator.new()
	rng.randomize()

	# Inicializar nubes de la explosión (fuego/humo)
	for i in range(CLOUDS_COUNT):
		var angle := rng.randf_range(0.0, TAU)
		var dist  := rng.randf_range(5.0, 30.0)
		_clouds.append({
			# Offset de posición usando polares
			"offset": Vector2(dist * cos(angle), dist * sin(angle)),
			"size_factor": rng.randf_range(0.6, 1.25),
			"fire_col": FIRE_COLORS[rng.randi_range(0, FIRE_COLORS.size() - 1)],
			"smoke_col": SMOKE_COLORS[rng.randi_range(0, SMOKE_COLORS.size() - 1)]
		})

	# Inicializar astillas (reutilizando polar → cartesiana)
	for i in range(ASTILLAS_COUNT):
		var base_angle := (TAU / ASTILLAS_COUNT) * i
		var jitter     := rng.randf_range(-0.25, 0.25)
		var theta      := base_angle + jitter

		_splinters.append({
			"theta":     theta,
			"rotation":  rng.randf_range(0.0, TAU),
			"width":     rng.randf_range(3.0, 6.0),
			"height":    rng.randf_range(8.0, 16.0),
			"color":     WOOD_COLORS[rng.randi_range(0, WOOD_COLORS.size() - 1)],
			# Distancia individual de dispersión
			"max_dist":  rng.randf_range(70.0, 110.0)
		})


func _draw() -> void:
	# ── 1. Onda de Choque en el Agua (Shockwave) ──────────────────────────────
	if _wave_radius > 1.0:
		var wave_color := Color(0.65, 0.90, 1.0, _alpha * 0.7)  # Cian/blanco
		# Dibujar el anillo de expansión con grosor
		draw_arc(Vector2.ZERO, _wave_radius, 0, TAU, 32, wave_color, 3.0, true)

	# ── 2. Nubes de Humo Gris ─────────────────────────────────────────────────
	if _smoke_radius > 1.0:
		for cloud in _clouds:
			var c: Color = cloud["smoke_col"]
			c.a *= _alpha
			var r: float = _smoke_radius * cloud["size_factor"]
			draw_circle(cloud["offset"], r, c)

	# ── 3. Nubes de Fuego Central ─────────────────────────────────────────────
	if _fire_radius > 1.0:
		for cloud in _clouds:
			var c: Color = cloud["fire_col"]
			# El fuego se desvanece antes que el humo
			c.a *= clamp((1.0 - (_fire_radius / 45.0)) * 2.0, 0.0, 1.0) * _alpha
			if c.a > 0.01:
				var r: float = _fire_radius * cloud["size_factor"] * 0.85
				draw_circle(cloud["offset"] * 0.6, r, c)

	# ── 4. Astillas de Madera Voladoras (Polar → Cartesiana) ──────────────────
	for splinter in _splinters:
		var theta: float = splinter["theta"]

		# Cálculo de posición polar a cartesiana individual
		var r: float = _progress * splinter["max_dist"]
		var pos := Vector2(r * cos(theta), r * sin(theta))

		# Giro de la astilla en el aire
		var angle: float = splinter["rotation"] + _progress * TAU * 2.5

		var w: float = splinter["width"]
		var h: float = splinter["height"]

		var half_w := w * 0.5
		var half_h := h * 0.5
		var verts := PackedVector2Array([
			Vector2(-half_w, -half_h),
			Vector2( half_w, -half_h),
			Vector2( half_w,  half_h),
			Vector2(-half_w,  half_h),
		])

		for j in range(verts.size()):
			verts[j] = verts[j].rotated(angle) + pos

		var c: Color = splinter["color"]
		c.a = _alpha
		# draw_polygon acepta color por vértice o un PackedColorArray
		draw_polygon(verts, PackedColorArray([c, c, c, c]))
