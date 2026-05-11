extends CanvasLayer

@onready var modal = $"../generic_modal"


func _on_return_to_map_btn_pressed() -> void:
	modal.mostrar_texto(
		"¿ESTÁS SEGURO DE VOLVER AL MAPA?",
		func():
			get_tree().paused = false

			get_tree().change_scene_to_file(
				"res://Scenes/Rooms/sea.tscn"
			)
	)
