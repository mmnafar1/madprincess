extends Node2D

@export var hexa_scene: PackedScene
const HEX_SIZE = Vector2(256, 256)
const COLS = 10
const ROWS = 12

func _ready():
	hexa_scene = preload("res://hexa_node.tscn")
	if hexa_scene == null:
		push_error("hexa_scene not assigned!")
		return
	
	for row in ROWS:
		for col in COLS:
			var hexa_instance = hexa_scene.instantiate()
			
			# Offset every other row for hex layout (flat-topped)
			var offset_x = (HEX_SIZE.x * 0.75) * col
			var offset_y = HEX_SIZE.y * 0.5 * row
			
			if row % 2 != 0:
				offset_x += HEX_SIZE.x * 0.375  # horizontal offset for odd rows
			
			hexa_instance.position = Vector2(offset_x, offset_y)
			add_child(hexa_instance)

	
func _process(delta):
	pass

func _on_start_pressed() -> void:
	pass # Replace with function body.


func _on_option_pressed() -> void:
	$".".hide()
	$"../OptionPage".show()


func _on_info_pressed() -> void:
	$".".hide()
	$"../InfoPannel".show()


func _on_quit_pressed() -> void:
	get_tree().quit()
