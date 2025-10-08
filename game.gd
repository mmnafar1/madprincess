extends Node2D
var oo = 0
var hexa_scene: PackedScene
#const HEX_SIZE = Vector2(25.6*2+3, 25.6*2+36)


func _put_da_tiles():
	#STARTO PUT THE TILES HERE
	var zzz = 0
	var start = get_viewport_rect().size/2
	hexa_scene = preload("res://hexa_node.tscn")
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
				hexa_instance.r = r
				hexa_instance.q = q
				hexa_instance.s = s
				hexa_instance.z_index = o
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
				if(abs(r)+abs(s)+abs(q) <= 2*Config.radius):
					Config.tiles.append(hexa_instance)
				if(abs(r)+abs(s)+abs(q) == 2*Config.radius):
					Config.edge_tiles.append(hexa_instance)
				add_child(hexa_instance)
func _put_da_princess():
	var start = get_viewport_rect().size/2
	var princess_scene = preload("res://princess.tscn")
	var princess = princess_scene.instantiate()
	princess.apply_scale(Vector2(2,2))
	princess.position = start - Vector2(0,23)
	add_child(princess)
func _put_a_monster():
	var monster_scene = preload("res://Monster.tscn")
	var new_monster = monster_scene.instantiate()
	new_monster.apply_scale(Vector2(1, 1))
	
	# Randomly choose one element from Config.edge_tiles
	var chosen_tile
	if Config.edge_tiles.size() > 0:
		var random_index = randi_range(0, Config.edge_tiles.size() - 1)
		chosen_tile = Config.edge_tiles[random_index]
		
		# Assuming each edge_tile has a 'position' property (like a Vector2)
		new_monster.position = chosen_tile.position - Vector2(0,23)
	else:
		push_warning("No edge tiles available to place a monster.")
	await chosen_tile._monster_spawn()
	add_child(new_monster)

func _monster_come() -> void:
	_put_a_monster()
	oo+=1
	if(oo>4):
		$MonsterTimer.wait_time = 0.5
func _put_a_choco():
	var choco_scene = preload("res://Chocolate.tscn")
	var new_choco = choco_scene.instantiate()
	new_choco.apply_scale(Vector2(1, 1))
	
	# Randomly choose one element from Config.edge_tiles
	if Config.tiles.size() > 0:
		var random_index = randi_range(0, Config.tiles.size() - 1)
		var chosen_tile = Config.tiles[random_index]
		
		# Assuming each edge_tile has a 'position' property (like a Vector2)
		new_choco.position = chosen_tile.position - Vector2(0,23)
	else:
		push_warning("No edge tiles available to place a monster.")
	
	add_child(new_choco)
func _choco_time() -> void:
	_put_a_choco()

func _remove_tile() -> void:
	var random_index = randi_range(0, Config.tiles.size() - 1)
	var chosen_tile = Config.tiles[random_index]
	chosen_tile._remove()
func _ready():
	_put_da_tiles()
	_put_da_princess()
	$MonsterTimer.wait_time = 3
	$MonsterTimer.start()
	$MonsterTimer.timeout.connect(_monster_come)
	$ChocolateTimer.wait_time = 4
	$ChocolateTimer.start()
	$ChocolateTimer.timeout.connect(_choco_time)
	#Engine.target_fps = 10
	#Engine.max_fps = 100
	pass


	
