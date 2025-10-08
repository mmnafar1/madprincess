extends Node
var radius = 8
var tiles = []
var edge_tiles = []
const SPEED := 150.0
const DEADZONE := 0.05  # tiny threshold to prevent jitter at near-zero input
const MONSTERSPEED := 100.0
const MONSTER_WAIT_TIME = 0.3
const TILE_COME_BACK = 50
const REALISTIC_MOVE = true
