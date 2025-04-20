extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"CanvasLayer/Units Deployed".text = "Units: " + str(Global.units)
	$"CanvasLayer/Turn Label".text = "Turn: " + str(Global.turn)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$"CanvasLayer/Units Deployed".text = "Units: " + str(Global.units)
	$"CanvasLayer/Turn Label".text = "Turn: " + str(Global.turn)
