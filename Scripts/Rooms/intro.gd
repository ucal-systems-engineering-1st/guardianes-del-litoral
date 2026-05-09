extends Control

const DIALOGUE_INTRO = preload("res://Dialogues/intro.dialogue")

@export var fondo_dr_habla: Texture2D
@export var fondo_valentina_habla: Texture2D
@export var fondo_dr_final: Texture2D

@onready var background: TextureRect = $TextureRect


func _ready() -> void:
	DialogueManager.passed_title.connect(_on_passed_title)

	await get_tree().process_frame

	var balloon = DialogueManager.show_dialogue_balloon(
		DIALOGUE_INTRO,
		"start"
	)

	balloon.tree_exited.connect(_on_dialogue_finished)


func _on_passed_title(title: String) -> void:
	var nueva_textura: Texture2D

	match title:
		"dr_1":
			nueva_textura = fondo_dr_habla

		"valentina":
			nueva_textura = fondo_valentina_habla

		"dr_2":
			nueva_textura = fondo_dr_final

	if nueva_textura:
		await _cambiar_fondo(nueva_textura)


func _cambiar_fondo(texture: Texture2D) -> void:
	var tween = create_tween()

	tween.tween_property(background, "modulate:a", 0.0, 0.2)

	await tween.finished

	background.texture = texture

	var tween2 = create_tween()

	tween2.tween_property(background, "modulate:a", 1.0, 0.2)

	await tween2.finished


func _on_dialogue_finished() -> void:
	await Transition.fade_out()

	get_tree().change_scene_to_file(
		"res://Scenes/Rooms/sea.tscn"
	)

	Transition.fade_in()
