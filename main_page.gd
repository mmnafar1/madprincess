extends Control



func _ready():
	pass
	
func _process(delta):
	pass

func _on_start_pressed() -> void:
	$".".hide()
	$"../Game".show()


func _on_option_pressed() -> void:
	$".".hide()
	$"../OptionPage".show()


func _on_info_pressed() -> void:
	$".".hide()
	$"../InfoPannel".show()


func _on_quit_pressed() -> void:
	get_tree().quit()
