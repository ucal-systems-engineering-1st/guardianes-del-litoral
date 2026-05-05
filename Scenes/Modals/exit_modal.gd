extends CanvasLayer

@onready var confirm_btn = $Panel/Contenedor/ConfirmBtn
@onready var exit_btn = $Panel/Contenedor/ExitBtn
@onready var panel = $Panel
@onready var audio = $Pause  # ← agrega este nodo

func _ready():
	visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	confirm_btn.pressed.connect(_on_si_pressed)
	exit_btn.pressed.connect(_on_no_pressed)

func _input(event):
	if event is InputEventKey:
		if event.keycode == KEY_ESCAPE and event.pressed:
			if not visible:
				_fade_in()
			else:
				_fade_out()

func _fade_in():
	visible = true
	get_tree().paused = true
	audio.play()  # ← suena al pausar
	panel.modulate.a = 0.0
	var tween = create_tween()
	tween.tween_property(panel, "modulate:a", 1.0, 0.3)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_LINEAR)

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
	get_tree().change_scene_to_file("res://control.tscn")

func _on_no_pressed():
	_fade_out()
