extends Area2D


func _ready() -> void:
	add_to_group("conchas")
	body_entered.connect(_on_body_entered)

	# Carga dinámica utilizando el path res:// directo que FileAccess y Image soportan
	var tex = _cargar_textura_dinamica("res://Resources/Player/sechura/scallop_shell.png")
	if tex:
		$Sprite2D.texture = tex


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Valentina":
		var nivel = get_tree().current_scene
		if nivel and nivel.has_method("recolectar_concha"):
			nivel.recolectar_concha()
		queue_free()


func _cargar_textura_dinamica(path: String) -> Texture2D:
	if FileAccess.file_exists(path):
		var img = Image.load_from_file(path)
		if img:
			return ImageTexture.create_from_image(img)
	return null
