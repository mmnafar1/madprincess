extends Node2D
var oo = 0
var hexa_scene: PackedScene
var current_time = 0
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
				hexa_instance.position = pos
				hexa_instance.base_position = pos
				if(abs(r)+abs(s)+abs(q) <= 2*Config.radius):
					Config.tiles.append(hexa_instance)
					if(r!=0 or s!=0 or q!=0):
						Config.remaining_tiles.append(hexa_instance)
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
		$MonsterTimer.wait_time = 0.25
func _put_a_choco():
	var choco_scene = preload("res://Chocolate.tscn")
	var new_choco = choco_scene.instantiate()
	new_choco.apply_scale(Vector2(1, 1))
	
	# Randomly choose one element from Config.edge_tiles
	if Config.remaining_tiles.size() > 0:
		var random_index = randi_range(0, Config.remaining_tiles.size() - 1)
		var chosen_tile = Config.remaining_tiles[random_index]
		
		# Assuming each edge_tile has a 'position' property (like a Vector2)
		new_choco.position = chosen_tile.position - Vector2(0,23)
		chosen_tile.choco = new_choco
	else:
		push_warning("No edge tiles available to place a monster.")
	
	add_child(new_choco)
func _choco_time() -> void:
	_put_a_choco()
var b = true
func _remove_tile() -> void:
	$TileRemoval.wait_time = Config.princess_mentality/100*2.5+0.45
	if(Config.remaining_tiles.size()>0):
		var random_index = randi_range(0, Config.remaining_tiles.size() - 1)
		if(b == true):
			random_index = 120
			b = false
		var chosen_tile = Config.remaining_tiles[random_index]
		chosen_tile._remove()
func _decay_dat_mental() -> void:
	if Config.blood_moon:
		Config.princess_mentality = max(0,Config.princess_mentality-Config.princess_mentality_blood_moon_decay)
	else:
		Config.princess_mentality = max(0,Config.princess_mentality-Config.princess_mentality_decay)
func _add_time():
	current_time += 1
	$GameTime.text = "TimeSoFar: "+str(current_time)
	if(current_time%(Config.blood_moon_start+Config.blood_moon_priod)>Config.blood_moon_start):
		Config.blood_moon=true
	if(current_time%(Config.blood_moon_start+Config.blood_moon_priod)<Config.blood_moon_start):
		Config.blood_moon=false
	
func _ready():
	Config.player = $Player
	_put_da_tiles()
	_put_da_princess()
	$MonsterTimer.wait_time = 1
	$MonsterTimer.start()
	$MonsterTimer.timeout.connect(_monster_come)
	$ChocolateTimer.wait_time = 6
	$ChocolateTimer.start()
	$ChocolateTimer.timeout.connect(_choco_time)
	$MentalDecayTimer.wait_time = 0.4
	$MentalDecayTimer.start()
	$MentalDecayTimer.timeout.connect(_decay_dat_mental)
	$TileRemoval.wait_time = 3
	$TileRemoval.start()
	$TileRemoval.timeout.connect(_remove_tile)
	$GameTimeTimer.wait_time = 1
	$GameTimeTimer.start()
	$GameTimeTimer.timeout.connect(_add_time)
	#Engine.max_fps = 100
	pass

func _process(delta: float) -> void:
	if not Config.blood_moon:
		#$Moon.position-=Vector2(0,440)/(Config.blood_moon_start*1.0)*delta
		$Path2D/PathFollow2D.progress_ratio+=1*delta/(Config.blood_moon_start*1.0)
		if(Config.blood_moon_start-current_time%(Config.blood_moon_start+Config.blood_moon_priod)<30):
			$Path2D/PathFollow2D/Moon.modulate -= Color(0,8,8)*delta/256
		else:
			$Path2D/PathFollow2D/Moon.modulate = Color.WHITE
			
	else:
		$Path2D/PathFollow2D/Moon.rotate(1*delta)
	if Config.player_health>0:
		$MeScore.text = "ScoreBe: "+str(Config.me_score)
	if(Config.player_health<0):
		print('game_Over')
	
