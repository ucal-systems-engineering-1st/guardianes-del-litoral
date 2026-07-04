extends Area2D

@onready var modal = $"../../game_over_stage_modal"

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("gaviotas"):
		modal.mostrar()
