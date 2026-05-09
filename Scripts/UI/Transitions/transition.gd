extends CanvasLayer

@onready var rect: ColorRect = $ColorRect


func _ready():
	rect.visible = false


func fade_in():
	rect.visible = true
	rect.modulate.a = 1.0

	var tween = create_tween()
	tween.tween_property(rect, "modulate:a", 0.0, 0.5)

	await tween.finished

	rect.visible = false


func fade_out():
	rect.visible = true
	rect.modulate.a = 0.0

	var tween = create_tween()
	tween.tween_property(rect, "modulate:a", 1.0, 0.5)

	await tween.finished
