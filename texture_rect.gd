extends TextureRect

func _ready():
	pass
	
func _process(delta):
	pass


func _on_button_pressed() -> void:
	$".".hide()
	$"../MainPage".show()
