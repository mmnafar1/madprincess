extends Node2D

var potions = [
	$P1,
	$P2,
	$P3
]
var type
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	type = randi_range(0, 2)
	var noder=potions[randi_range(0, 2)]
	noder.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
