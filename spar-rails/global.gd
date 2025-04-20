extends Node

var isPlayerTurn = true
var selectingTarget = false
var selectedMoveDamage = 0
var selectedMoveType = "typeless"
var selectedUnit = null
var selectedEnemy = null
var units = 0
var turn = 1

func _ready() -> void:
	units = get_tree().get_nodes_in_group("FriendlyUnits").size()
	
func _process(delta: float) -> void:
	units = get_tree().get_nodes_in_group("FriendlyUnits").size()
