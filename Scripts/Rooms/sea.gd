extends Node2D

@onready var animation = $Sea_bg
@onready var gestor: Node = $GestorContaminacion

func _ready():
	animation.play("sea_movement")
	_registrar_zonas_vulnerables()
	if gestor:
		gestor.connect("hit_rate_actualizado", _on_hit_rate_actualizado)


func _registrar_zonas_vulnerables() -> void:
	# Agrega cada zona costera al grupo para que el gestor las detecte
	for nombre in ["Paracas", "Islas Ballestas", "Sechura", "Villa", "San Juan"]:
		var zona = get_node_or_null(nombre)
		if zona:
			zona.add_to_group("zonas_vulnerables")


func _on_hit_rate_actualizado(nuevo_hit_rate: float) -> void:
	# hit_rate disponible para mostrar en UI o bitácora
	print("Hit rate actual: %.0f%%" % (nuevo_hit_rate * 100))