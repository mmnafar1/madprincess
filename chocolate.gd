extends Node2D

var jahat = 1
var potions
var type
var noder
# Called when the node enters the scene tree for the first time.
var scals = []
func _ready() -> void:
	potions = [
	$StaticBody2D/PopsicleBv6,
	$StaticBody2D/P1,
	$StaticBody2D/P2,
	$StaticBody2D/P3
]
	scals = [
	$StaticBody2D/PopsicleBv6.scale.x,
	$StaticBody2D/P1.scale.x,
	$StaticBody2D/P2.scale.x,
	$StaticBody2D/P3.scale.x
	]
	type = randi_range(0, 3+Config.chocho_likly)
	if type < Config.chocho_likly:
		type = 0
	else:
		type-=Config.chocho_likly
	noder=potions[type]
	print(type,noder)
	noder.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	noder.scale.x -= jahat*0.05*scals[type]/1.3
	if(noder.scale.x<=-1*scals[type]):
		jahat = -1
	if(noder.scale.x>=1*scals[type]):
		jahat = 1
	
		
	
	
