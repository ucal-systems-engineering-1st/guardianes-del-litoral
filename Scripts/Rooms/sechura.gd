extends Area2D

@export var nombre_lugar: String = "BAHÍA DE SECHURA"

func _ready():
	body_entered.connect(_on_enter)

func _on_enter(body):
	if body.name == "Ship":
		var modal = get_parent().get_node("generic_modal")

		modal.mostrar(nombre_lugar, func():
			print("Explorando:", nombre_lugar)
			get_tree().change_scene_to_file("res://Scenes/Rooms/bahia_sechura.tscn")
		)
