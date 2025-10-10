extends Node
var radius = 10
var tiles = []
var remaining_tiles = []
var edge_tiles = []
const SPEED := 150.0
const DEADZONE := 0.05  # tiny threshold to prevent jitter at near-zero input
var MONSTERSPEED := 100.0
const MONSTER_WAIT_TIME = 0.3
const TILE_COME_BACK = 50
const REALISTIC_MOVE = true
var princess_mentality = 100
var player_health = 100
var monster_damage = 10
const drop_damage = 20
var choco_goodness = 10
var player
const princess_mentality_decay = 0.5
const princess_mentality_blood_moon_decay = 2
var blood_moon_start = 60
var blood_moon_priod = 30
var blood_moon = false
var chocho_likly = 8
var me_score = 0
