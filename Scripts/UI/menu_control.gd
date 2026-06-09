extends Control

@onready var btn_jugar = $VBoxContainer/BtnJugar
@onready var btn_salir = $VBoxContainer/BtnSalir

func _ready():
	# Conectar botones
	btn_jugar.pressed.connect(_on_btn_jugar_pressed)
	btn_salir.pressed.connect(_on_btn_salir_pressed)

func _on_btn_jugar_pressed():
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0, 0.5)
	await tween.finished
	get_tree().change_scene_to_file("res://Scenes/Rooms/Intro.tscn")

func _on_btn_salir_pressed():
	# Cerrar el juego
	get_tree().quit()
