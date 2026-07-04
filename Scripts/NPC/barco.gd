extends StaticBody2D
@onready var modal = $"../generic_modal"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("Llegó al barco")
		modal.mostrar_texto(
		"¿ESTÁS SEGURO DE VOLVER AL MAPA?",
		func():
			get_tree().paused = false

			get_tree().change_scene_to_file(
				"res://Scenes/Rooms/sea.tscn"
			)
	)
