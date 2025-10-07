extends Node2D

@onready var anim: AnimatedSprite2D = $CharacterBody2D/AnimatedSprite2D

# Order corresponds to angle sectors starting at +X (right) going CCW
var _dir_names := [
	"E",
	"NE",
	"N",
	"NW",
	"W",
	"SW",
	"S",
	"SE"
]

var player
var target_position
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready() -> void:
	$Timer.wait_time = Config.MONSTER_WAIT_TIME
	$Timer.start()
	$Timer.timeout.connect(_on_timer_timeout)
	player = $"../Player/Player"
	target_position = player.global_position
func _on_timer_timeout() -> void:
	if player:
		target_position = player.global_position

func _physics_process(delta: float) -> void:
	var direction = (target_position - $CharacterBody2D.global_position).normalized()
	$CharacterBody2D.velocity = direction * Config.MONSTERSPEED
	$CharacterBody2D.move_and_slide()
	_update_animation((target_position - global_position).normalized())



func _update_animation(direction: Vector2) -> void:
	if direction.length() > Config.DEADZONE:
		# Convert to angle [0..2π) and quantize into 8 sectors
		var angle := atan2(-direction.y, direction.x)  # screen Y+ is down; negate to make up positive
		if angle < 0.0:
			angle += TAU
		var sector := int(roundi(angle / (PI / 4.0))) % 8
		var name = _dir_names[sector]
		_play_once("Walk_" + name)
	else:
		#var idle_name = "Idle_" + _dir_names[_last_dir_idx]
		#_play_once(idle_name)
		print("Error")

func _play_once(target: String) -> void:
	if anim.animation != target:
		anim.play(target)
		#print('anime played', target)
