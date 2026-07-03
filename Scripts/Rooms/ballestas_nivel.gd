extends Node2D

const DIALOGUE_BALLESTAS = preload("res://Dialogues/ballestas.dialogue")

@onready var valentina = $Valentina

func _ready():

	valentina.speed = 0

	await get_tree().process_frame

	var balloon = DialogueManager.show_dialogue_balloon(
		DIALOGUE_BALLESTAS,
		"start"
	)

	balloon.tree_exited.connect(_on_dialogue_finished)


func _on_dialogue_finished():

	valentina.speed = 180
	for gaviota in get_tree().get_nodes_in_group("gaviotas"):
		gaviota.puede_volar = true
