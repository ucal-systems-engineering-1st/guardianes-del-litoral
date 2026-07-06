extends Area2D

signal dialogo_solicitado

@export var textura_reposo: Texture2D
@export var textura_hablando: Texture2D

## Distancia (px en espacio global) a la que se activa el rebote
@export var distancia_rebote: float = 50.0
## Fuerza del impulso de rebote
@export var fuerza_rebote: float = 1100.0

var valentina_en_rango: bool = false
var mision_dada: bool = false
var _valentina: CharacterBody2D = null
var _rebote_cooldown: float = 0.0

@onready var sprite: Sprite2D = $Sprite2D
@onready var indicador: Label = $Indicador


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

	# Intentar carga dinámica para evitar problemas de importación corrupta de Godot
	var tex = _cargar_textura_dinamica("res://Resources/Player/marco/marco.png")
	if tex:
		sprite.texture = tex
	elif textura_reposo:
		sprite.texture = textura_reposo


func _process(delta: float) -> void:
	if _rebote_cooldown > 0.0:
		_rebote_cooldown -= delta

	# Rebote: empujar a Valentina si está demasiado cerca
	if _valentina and is_instance_valid(_valentina) and _rebote_cooldown <= 0.0:
		var dist = global_position.distance_to(_valentina.global_position)
		if dist < distancia_rebote:
			_rebote_cooldown = 0.5
			var dir = (_valentina.global_position - global_position).normalized()
			_valentina.apply_knockback(dir * fuerza_rebote)

	# Diálogo al presionar acción
	if valentina_en_rango and not mision_dada:
		if Input.is_action_just_pressed("interact"):
			mision_dada = true
			indicador.hide()
			dialogo_solicitado.emit()


func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and body.name == "Valentina" and not mision_dada:
		_valentina = body as CharacterBody2D
		indicador.show()
		valentina_en_rango = true


func _on_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D and body.name == "Valentina":
		_valentina = null
		indicador.hide()
		valentina_en_rango = false


func _cargar_textura_dinamica(path: String) -> Texture2D:
	if FileAccess.file_exists(path):
		var img = Image.load_from_file(path)
		if img:
			return ImageTexture.create_from_image(img)
	return null
