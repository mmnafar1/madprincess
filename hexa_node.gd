extends Node2D

var r: int
var q: int
var s: int
var stat = 0
var base_position
var choco
func _ready():
	#var img = Image.new()
	#var err = img.load("res://Assets/tiles/"+str(randi_range(2, 2))+".png")
	#if err == OK:
		#var tex = ImageTexture.create_from_image(img)
		#$Area2D/s2.texture = tex
	#else:
		#print("Failed to load image:", err)
	$Timer.timeout.connect(_come_back)
	pass

func _monster_spawn():
	$Area2D/s2/Line2D.default_color = Color.BROWN
	$Area2D/s2/Line2D.show()
	await get_tree().create_timer(1).timeout
	$Area2D/s2/Line2D.hide()
func _remove():
	Config.remaining_tiles.erase(self)
	stat = 1
	for i in range(10):
		await get_tree().create_timer(0.1).timeout
		$Area2D/s2.position += Vector2(0,10)
		if(i==3):
			stat = 2
			if(choco != null):
				choco.queue_free()
				choco = null
	if(stat == 2):
		hide()
	$Timer.wait_time = Config.TILE_COME_BACK
	$Timer.start()
	
	
func _come_back():
	if stat != 2:
		return
	stat = 1
	show()
	for i in range(10):
		await get_tree().create_timer(0.1).timeout
		if base_position != $Area2D/s2.position:
			$Area2D/s2.position -= Vector2(0,10)
		if(i>8):
			stat = 0
	Config.remaining_tiles.append(self)
	#show()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if(stat == 2 and body.is_in_group("monster")):
		body._drop(z_index)
	if(stat == 2 and body.is_in_group("player")):
		Config.player_health -= Config.drop_damage
		Config.player.get_child(0)._player_took_damage()
		_come_back()
