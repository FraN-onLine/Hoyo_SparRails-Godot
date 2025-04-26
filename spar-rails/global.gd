extends Node

var isPlayerTurn = true
var selectingTarget = false
var selectedMoveDamage = 0
var selectedMoveType = "typeless"
var selectedUnit = null
var selectedEnemy = null
var units = 0
var enemies = 0
var turn = 1
var level = 0

func _ready() -> void:
	units = get_tree().get_nodes_in_group("FriendlyUnits").size()
	enemies = get_tree().get_nodes_in_group("HostileUnits").size()
func _process(delta: float) -> void:
	units = get_tree().get_nodes_in_group("FriendlyUnits").size()
	enemies = get_tree().get_nodes_in_group("HostileUnits").size()
	
	if enemies == 0:
		isPlayerTurn = true
