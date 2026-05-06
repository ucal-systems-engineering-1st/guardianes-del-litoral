extends Button

func _ready():
	pivot_offset = size / 2
	respirar()

func respirar():
	var tween = create_tween()
	tween.set_loops()
	
	tween.tween_property(self, "scale", Vector2(1.05, 1.05), 1.2)\
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	tween.tween_property(self, "scale", Vector2(1.0, 1.0), 1.2)\
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
