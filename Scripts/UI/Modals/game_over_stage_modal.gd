extends CanvasLayer

@onready var confirm_btn = $Panel/Contenedor/ConfirmBtn
@onready var exit_btn = $Panel/Contenedor/ExitBtn
@onready var panel = $Panel
@onready var audio = $GameOver

# Cambia esta ruta por la de tu mapa principal
const MAPA_PRINCIPAL = "res://Scenes/Rooms/sea.tscn"

func _ready():
	visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS

	confirm_btn.pressed.connect(_on_si_pressed)
	exit_btn.pressed.connect(_on_no_pressed)

func mostrar():
	await _fade_in()

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ESCAPE and visible:
			await _fade_out()

func _fade_in():
	visible = true
	get_tree().paused = true

	audio.play()

	panel.modulate.a = 0.0

	var tween = create_tween()
	tween.tween_property(panel, "modulate:a", 1.0, 0.3)

	await tween.finished

func _fade_out():
	var tween = create_tween()
	tween.tween_property(panel, "modulate:a", 0.0, 0.3)

	await tween.finished

	visible = false
	get_tree().paused = false

func _on_si_pressed():

	get_tree().paused = false

	await Transition.fade_out()

	# Reinicia el nivel actual
	get_tree().reload_current_scene()

	Transition.fade_in()

func _on_no_pressed():

	get_tree().paused = false

	await Transition.fade_out()

	# Volver al mapa
	get_tree().change_scene_to_file(MAPA_PRINCIPAL)

	Transition.fade_in()
