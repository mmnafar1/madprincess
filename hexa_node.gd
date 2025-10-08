extends Node2D

var r: int
var q: int
var s: int
var stat = 0
func _ready():
	#var img = Image.new()
	#var err = img.load("res://Assets/tiles/"+str(randi_range(2, 2))+".png")
	#if err == OK:
		#var tex = ImageTexture.create_from_image(img)
		#$Area2D/s2.texture = tex
	#else:
		#print("Failed to load image:", err)
	pass

func _monster_spawn():
	$Area2D/s2/Line2D.default_color = Color.BROWN
	$Area2D/s2/Line2D.show()
	await get_tree().create_timer(1).timeout
	$Area2D/s2/Line2D.hide()
func _remove():
	stat = 1
	for i in range(10):
		await get_tree().create_timer(0.1).timeout
		$Area2D/s2.position += Vector2(0,10)
		if(i>2):
			stat = 2
	hide()
	$Timer.wait_time = Config.TILE_COME_BACK
	$Timer.start()
	$Timer.timeout.connect(_come_back)
func _come_back():
	if stat != 2:
		return
	stat = 1
	show()
	for i in range(10):
		await get_tree().create_timer(0.1).timeout
		$Area2D/s2.position -= Vector2(0,10)
		if(i>8):
			stat = 0
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	if(stat == 2 and body.is_in_group("monster")):
		body._drop(z_index)
