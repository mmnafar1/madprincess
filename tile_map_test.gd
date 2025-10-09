extends Node2D
var oo = 0
var hexa_scene: PackedScene
#const HEX_SIZE = Vector2(25.6*2+3, 25.6*2+36)


func _put_da_tiles():
	#STARTO PUT THE TILES HERE
	var zzz = 0
	var start = get_viewport_rect().size/2
	hexa_scene = preload("res://avoo_tile.tscn")
	var hexa_border_scene = preload("res://hexa_border_node.tscn")
	if hexa_scene == null:
		push_error("hexa_scene not assigned!")
		return
	var o = 0
	var redarus = Config.radius+1
	for r in range(0-redarus,redarus+1):
		for q in range(0-redarus,redarus+1):
			for s in range(0-redarus,redarus+1):
				if(r+q+s !=0):
					continue
				
				o+=1
				var hexa_instance
				if (abs(r)+abs(s)+abs(q) != 2*redarus):
					hexa_instance = hexa_scene.instantiate()
				else:
					hexa_instance = hexa_border_scene.instantiate()
				#hexa_instance.r = r
				#hexa_instance.q = q
				#hexa_instance.s = s
				hexa_instance.z_index = o
				var scaler = 20.0
				hexa_instance.apply_scale(Vector2(1,1)/scaler)
				hexa_instance.get_node("Label").text = str(r)+','+str(q)+','+str(s)
				#var offset_next_col = Vector2(1144,-5)/scaler
				#var offset_odd_row = (Vector2(574,616)-Vector2(1144,-5)/2)/scaler
				var offset_next_col = Vector2(1113,-14)/scaler
				var offset_odd_row = (Vector2(564,583)-Vector2(1113,-14)/2.0)/scaler
				var pos = start
				pos += (q-s)/2.0*offset_next_col + r*offset_odd_row
				hexa_instance.position = pos
				if(abs(r)+abs(s)+abs(q) <= 2*Config.radius):
					Config.tiles.append(hexa_instance)
				if(abs(r)+abs(s)+abs(q) == 2*Config.radius):
					Config.edge_tiles.append(hexa_instance)
				add_child(hexa_instance)

func _ready():
	_put_da_tiles()




	
