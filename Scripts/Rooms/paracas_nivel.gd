extends Node2D

@onready var gestor: Node = $GestorContaminacion
@onready var dr_alejandro = $DrAlejandro


func _ready() -> void:
	if gestor:
		gestor.connect("hit_rate_actualizado", _on_hit_rate_actualizado)
	dr_alejandro.dialogo_solicitado.connect(_on_dr_alejandro_dialogo)


func _on_hit_rate_actualizado(nuevo_hit_rate: float) -> void:
	print("Paracas — hit rate: %.0f%%" % (nuevo_hit_rate * 100))


func _on_dr_alejandro_dialogo() -> void:
	var dialogo = load("res://Dialogues/paracas_nivel.dialogue")
	if dialogo:
		DialogueManager.show_dialogue_balloon(dialogo, "mision_1_inicio")
