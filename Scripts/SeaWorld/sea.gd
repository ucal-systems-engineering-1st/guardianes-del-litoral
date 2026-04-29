extends Node2D


@onready var animation = $Sea_bg

func _ready():
	animation.play("sea_movement")


