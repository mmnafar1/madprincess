extends Node2D

func _ready():
	var img = Image.new()
	var err = img.load("res://Assets/tiles/"+str(randi_range(2, 2))+".png")
	if err == OK:
		var tex = ImageTexture.create_from_image(img)
		$Area2D/s2.texture = tex
	else:
		print("Failed to load image:", err)
