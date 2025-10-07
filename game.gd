extends Node2D

var hexa_scene: PackedScene
#const HEX_SIZE = Vector2(25.6*2+3, 25.6*2+36)


func _put_da_tiles():
	#STARTO PUT THE TILES HERE
	var start = get_viewport_rect().size/2
	hexa_scene = preload("res://hexa_node.tscn")
	if hexa_scene == null:
		push_error("hexa_scene not assigned!")
		return
	var o = 0
	for r in range(0-Config.radius,Config.radius+1):
		for q in range(0-Config.radius,Config.radius+1):
			for s in range(0-Config.radius,Config.radius+1):
				if(r+q+s !=0):
					continue
				o+=1
				var hexa_instance = hexa_scene.instantiate()
				hexa_instance.r = r
				hexa_instance.q = q
				hexa_instance.s = s
				var scaler = 3.0
				hexa_instance.apply_scale(Vector2(1,1)/scaler)
				hexa_instance.get_node("Label").text = str(r)+','+str(q)+','+str(s)
				var offset_next_col = Vector2(194,14)/scaler
				var offset_odd_row = Vector2(-24.5,92.5)/scaler
				var pos = start
				pos += (q-s)/2.0*offset_next_col + r*offset_odd_row
				if(r==1 and q ==-1 and s==0):
					print((q-s)/2)
				hexa_instance.position = pos
				Config.tiles.append(hexa_instance)
				add_child(hexa_instance)
func _put_da_princess():
	var start = get_viewport_rect().size/2
	var princess_scene = preload("res://princess.tscn")
	var princess = princess_scene.instantiate()
	princess.apply_scale(Vector2(3,3))
	princess.position = start - Vector2(10,20)
	add_child(princess)
func _ready():
	_put_da_tiles()
	_put_da_princess()

	
