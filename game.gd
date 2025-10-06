extends Node2D

@export var hexa_scene: PackedScene
const HEX_SIZE = Vector2(25.6*2+3, 25.6*2+36)
const COLS = 12
const ROWS = 10
#const middle = get_viewport_rect().size
#$"..".Transform.size
func _ready():
	var start = get_viewport_rect().size/2
	hexa_scene = preload("res://hexa_node.tscn")
	if hexa_scene == null:
		push_error("hexa_scene not assigned!")
		return
	#for col in COLS:
		#for row in ROWS:
			#var hexa_instance = hexa_scene.instantiate()
			#hexa_instance.apply_scale(Vector2(0.2,0.2))
			#hexa_instance.z_index = row*2
			#var offset_x = (HEX_SIZE.x * 0.75) * col
			#var offset_y = HEX_SIZE.y * 0.5 * row
			#if col % 2 != 0:
				#offset_y -= HEX_SIZE.y * 0.250
				#hexa_instance.z_index = row*2 -1
			#print(col,',',row,',',hexa_instance.z_index)
			#hexa_instance.position = start + Vector2(offset_x, offset_y)
			#add_child(hexa_instance)
	#for row in ROWS:
		#for col in COLS:
			#var hexa_instance = hexa_scene.instantiate()
			#var scaler = 3
			#hexa_instance.apply_scale(Vector2(1,1)/scaler)
			#var HEX_SIZE = Vector2(hexa_instance.get_node("Area2D/s2").texture.get_width(),hexa_instance.get_node("Area2D/s2").texture.get_height())/scaler
			##hexa_instance.z_index = 100-row
			#var offset_next_col = Vector2(195,0)/scaler
			##var offset_odd_row = Vector2(73,99)/scaler
			#var offset_odd_row = Vector2(-120,84)/scaler
			#var pos = start
			#pos += col*offset_next_col + row*offset_odd_row
			##if row % 2 != 0:
				##offset_x += HEX_SIZE.x * 0.375  # horizontal offset for odd rows
			#
			#hexa_instance.position = pos
			#add_child(hexa_instance)
	var radius = 6
	var o = 0
	for r in range(0-radius,radius+1):
		for q in range(0-radius,radius+1):
			for s in range(0-radius,radius+1):
				if(r+q+s !=0):
					continue
				o+=1
				var hexa_instance = hexa_scene.instantiate()
				var scaler = 3.0
				hexa_instance.apply_scale(Vector2(1,1)/scaler)
				hexa_instance.get_node("Label").text = str(r)+','+str(q)+','+str(s)
				#var HEX_SIZE = Vector2(hexa_instance.get_node("Area2D/s2").texture.get_width(),hexa_instance.get_node("Area2D/s2").texture.get_height())/scaler
				#hexa_instance.z_index = 100-row
				var offset_next_col = Vector2(194,14)/scaler
				#var offset_odd_row = Vector2(73,99)/scaler
				var offset_odd_row = Vector2(-24.5,92.5)/scaler
				var pos = start
				pos += (q-s)/2.0*offset_next_col + r*offset_odd_row
				if(r==1 and q ==-1 and s==0):
					print((q-s)/2)
					
				hexa_instance.position = pos
				add_child(hexa_instance)
	print(o)
