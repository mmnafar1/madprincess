extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
func _draw() -> void:
	var start = Vector2(-150, -281)
	var end = Vector2(500, 400)
	draw_line(start, end, Color.BLUE, 20.0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
