## game_over_modal.gd
## Modal de "Game Over" que aparece cuando el Ship del jugador pierde toda la vida.
## Estructura idéntica a generic_modal.gd pero con textos y callbacks fijos.

extends CanvasLayer

@onready var confirm_btn := $Panel/Contenedor/ConfirmBtn  # "Volver a intentarlo"
@onready var exit_btn    := $Panel/Contenedor/ExitBtn     # "No"
@onready var panel       := $Panel
@onready var audio       := $Pause


func _ready() -> void:
	visible = false
	# Funcionar aunque el árbol esté pausado (fundamental para el game over)
	process_mode = Node.PROCESS_MODE_ALWAYS

	confirm_btn.pressed.connect(_on_reintentar)
	exit_btn.pressed.connect(_on_salir)


## Mostrar el modal con fade in y pausar el juego
func mostrar() -> void:
	await _fade_in()


# ── Callbacks de botones ──────────────────────────────────────────────────────

func _on_reintentar() -> void:
	get_tree().paused = false
	await _fade_out()
	get_tree().reload_current_scene()


func _on_salir() -> void:
	get_tree().paused = false
	await _fade_out()
	get_tree().change_scene_to_file("res://Scenes/Rooms/Intro.tscn")


# ── Transiciones ─────────────────────────────────────────────────────────────

func _fade_in() -> void:
	visible = true
	get_tree().paused = true
	audio.play()
	panel.modulate.a = 0.0

	var tween := create_tween()
	tween.tween_property(panel, "modulate:a", 1.0, 0.3)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_LINEAR)

	await tween.finished


func _fade_out() -> void:
	var tween := create_tween()
	tween.tween_property(panel, "modulate:a", 0.0, 0.3)\
		.set_ease(Tween.EASE_IN)\
		.set_trans(Tween.TRANS_LINEAR)

	await tween.finished
	visible = false
