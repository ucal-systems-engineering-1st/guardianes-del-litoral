extends Area2D

var valentina_en_rango: bool = false
@onready var indicador: Label = $Indicador


func _ready() -> void:
	add_to_group("algas")
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	if indicador:
		indicador.hide()

	# Carga dinámica utilizando el path res:// directo que FileAccess y Image soportan
	var tex = _cargar_textura_dinamica("res://Resources/Player/sechura/red_algae.png")
	if tex:
		$Sprite2D.texture = tex


func _process(_delta: float) -> void:
	if valentina_en_rango:
		if Input.is_action_just_pressed("interact"):
			var nivel = get_tree().current_scene
			if nivel and nivel.has_method("limpiar_alga"):
				nivel.limpiar_alga()
			queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Valentina":
		valentina_en_rango = true
		if indicador:
			indicador.show()


func _on_body_exited(body: Node2D) -> void:
	if body.name == "Valentina":
		valentina_en_rango = false
		if indicador:
			indicador.hide()


func _cargar_textura_dinamica(path: String) -> Texture2D:
	if FileAccess.file_exists(path):
		var img = Image.load_from_file(path)
		if img:
			return ImageTexture.create_from_image(img)
	return null
