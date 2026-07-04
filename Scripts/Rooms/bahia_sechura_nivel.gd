extends Node2D

const DIALOGUE_SECHURA = preload("res://Dialogues/sechura_nivel.dialogue")

@onready var valentina = $Valentina
@onready var npc_marco = $NPCMarco
@onready var estanque = $EstanquePurificador
@onready var hud_label = $CanvasLayer/HUD/Panel/Label

var conchas_recolectadas: int = 0
var conchas_en_estanque: int = 0
var mision_activa: bool = false
var mision_completada: bool = false


func _ready() -> void:
	# Ocultar HUD al inicio
	$CanvasLayer/HUD.hide()

	# Conectar diálogo del NPC
	npc_marco.dialogo_solicitado.connect(_on_marco_dialogo_solicitado)

	# Conectar interacción con el estanque
	estanque.body_entered.connect(_on_estanque_body_entered)

	# Desconectar colisiones de conchas hasta hablar con Marco
	_set_conchas_activas(false)
	_set_algas_activas(false)


func _on_marco_dialogo_solicitado() -> void:
	if not mision_activa:
		# Congelar a Valentina durante el diálogo
		valentina.speed = 0
		var balloon = DialogueManager.show_dialogue_balloon(DIALOGUE_SECHURA, "mision_sechura_inicio")
		balloon.tree_exited.connect(_on_dialogue_inicio_finished)
	elif mision_completada:
		valentina.speed = 0
		var balloon = DialogueManager.show_dialogue_balloon(DIALOGUE_SECHURA, "mision_sechura_completa")
		balloon.tree_exited.connect(_on_dialogue_completo_finished)


func _on_dialogue_inicio_finished() -> void:
	valentina.speed = 180
	mision_activa = true
	$CanvasLayer/HUD.show()
	_actualizar_hud()
	_set_conchas_activas(true)
	_set_algas_activas(true)


func _on_dialogue_completo_finished() -> void:
	# Transición de regreso al mapa global
	Transition.change_scene("res://Scenes/Rooms/sea.tscn")


func _set_conchas_activas(activar: bool) -> void:
	for concha in get_tree().get_nodes_in_group("conchas"):
		concha.set_deferred("monitoring", activar)
		concha.visible = activar


func _set_algas_activas(activar: bool) -> void:
	for alga in get_tree().get_nodes_in_group("algas"):
		alga.set_deferred("monitoring", activar)
		alga.visible = activar


func recolectar_concha() -> void:
	conchas_recolectadas += 1
	_actualizar_hud()


func limpiar_alga() -> void:
	# Otorgar 10 PK (Puntos de Conocimiento)
	print("+10 PK obtenidos por limpiar alga nociva.")


func _on_estanque_body_entered(body: Node2D) -> void:
	if body.name == "Valentina" and conchas_recolectadas > 0:
		conchas_en_estanque += conchas_recolectadas
		conchas_recolectadas = 0
		_actualizar_hud()

		if conchas_en_estanque >= 5:
			mision_completada = true
			npc_marco.mision_dada = false # Permitir interactuar de nuevo para la decisión
			# Mostrar mensaje temporal en el HUD en español latino
			hud_label.text = "¡Misión completada! Habla con Marco."


func _actualizar_hud() -> void:
	if not mision_completada:
		hud_label.text = "Llevas: %d | En Estanque: %d/5" % [conchas_recolectadas, conchas_en_estanque]
