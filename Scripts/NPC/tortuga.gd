extends CharacterBody2D

@export var speed: float = 60.0
@export var offset_detras: float = 40.0

enum Estado { QUIETA, PERSIGUIENDO }
var estado: Estado = Estado.QUIETA
var _valentina: CharacterBody2D = null

@onready var area_deteccion: Area2D = $AreaDeteccion


func _ready() -> void:
	area_deteccion.body_entered.connect(_on_body_entered)


func _physics_process(_delta: float) -> void:
	if get_tree().paused:
		velocity = Vector2.ZERO
		move_and_slide()
		return

	if Input.is_action_just_pressed("ui_cancel"):
		estado = Estado.QUIETA

	if estado == Estado.PERSIGUIENDO and _valentina and is_instance_valid(_valentina):
		var val_vel = _valentina.velocity
		var objetivo: Vector2
		if val_vel.length() > 1.0:
			# Apuntar al punto detrás de Valentina (opuesto a su dirección de movimiento)
			objetivo = _valentina.global_position - val_vel.normalized() * offset_detras
		else:
			objetivo = _valentina.global_position
		var direccion = (objetivo - global_position).normalized()
		velocity = direccion * speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()


func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and body.name == "Valentina":
		_valentina = body as CharacterBody2D
		estado = Estado.PERSIGUIENDO
