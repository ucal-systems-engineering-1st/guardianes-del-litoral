extends CanvasLayer

@onready var confirm_btn = $Panel/Contenedor/ConfirmBtn
@onready var exit_btn = $Panel/Contenedor/ExitBtn
@onready var panel = $Panel
@onready var audio = $Pause


func _ready():
	visible = false

	process_mode = Node.PROCESS_MODE_ALWAYS

	confirm_btn.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	exit_btn.process_mode = Node.PROCESS_MODE_WHEN_PAUSED

	confirm_btn.pressed.connect(_on_si_pressed)
	exit_btn.pressed.connect(_on_no_pressed)


# ESTA FUNCIÓN SE CONECTA DESDE SalirBtn -> pressed()
func _on_salir_btn_pressed():
	if not visible:
		await _fade_in()
	else:
		await _fade_out()


func _fade_in():
	visible = true

	get_tree().paused = true

	audio.play()

	panel.modulate.a = 0.0

	var tween = create_tween()

	tween.tween_property(panel, "modulate:a", 1.0, 0.3)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_LINEAR)

	await tween.finished


func _fade_out():
	var tween = create_tween()

	tween.tween_property(panel, "modulate:a", 0.0, 0.3)\
		.set_ease(Tween.EASE_IN)\
		.set_trans(Tween.TRANS_LINEAR)

	await tween.finished

	visible = false

	get_tree().paused = false


func _on_si_pressed():
	get_tree().paused = false

	var tween = create_tween()

	tween.tween_property(panel, "modulate:a", 0.0, 0.5)\
		.set_ease(Tween.EASE_IN)\
		.set_trans(Tween.TRANS_LINEAR)

	await tween.finished

	visible = false

	await Transition.change_scene(
		"res://Scenes/Rooms/control.tscn"
	)


func _on_no_pressed():
	await _fade_out()
