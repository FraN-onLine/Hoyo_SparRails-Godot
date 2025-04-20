extends Node

class_name Enemy

signal healthChanged
signal skillUsed

var max_health
var previous_health = health
var health = max_health
var dead = false

@onready var sprite = $Sprite2D
@onready var healthbar: ProgressBar = $Healthbar
@export var stats: UnitStats
var actionTaken = false

func _ready():
	$Sprite2D.texture = stats.characterSprite
	$Weakness.texture = stats.weaknessSprite
	$Name.text = stats.character_name
	health = stats.max_health
	healthbar.init_health(stats.max_health)
	$HP.text = str(health) + "/" + str(stats.max_health) 
	$Sprite2D/AnimationPlayer.play("Bounce")
	
func _process(delta):
	if Global.isPlayerTurn == false and actionTaken == false:
		actionTaken = true
		await get_tree().create_timer(0.3).timeout
		var random_move = randi() % 2 + 1  # Randomly choose between move1 or move2		
		var units = get_tree().get_nodes_in_group("FriendlyUnits")  # Assuming units are in this group
		if units.size() > 0:
			var target = units[randi() % units.size()]  # Randomly select a target
			if random_move == 1:
				move1_used()
				target.take_damage(stats.move1_damage, stats.move1_element)  # Assuming target has a take_damage method
			elif random_move == 2:
				move2_used()
				target.take_damage(stats.move_2_damage, stats.move_2_element)  # Example: move2 deals more damage
		Global.turn += 1
	elif Global.isPlayerTurn == true:
			actionTaken = false
			
			
func _on_area_2d_mouse_entered():
	if Global.selectingTarget:
		$Sprite2D.modulate = Color(155, 0, 0)  # Highlight red
				

func _on_area_2d_mouse_exited():
	if Global.selectingTarget:
		$Sprite2D.modulate = Color(1, 1, 1)  # Highlight red
		
func _on_area_2d_input_event(viewport, event, shape_idx):
	if Global.selectingTarget and event is InputEventMouseButton and event.pressed:
			self.take_damage(Global.selectedMoveDamage, Global.selectedMoveType)
			$Sprite2D.modulate = Color(1, 1, 1)  # Highlight red
			Global.selectingTarget = false
			Global.isPlayerTurn = false


func take_damage(damage, attack_type):
	if(stats.weakness == attack_type):
		health -= damage * 1.5
	else:
		health -= damage
	healthbar._set_health(health)
	emit_signal("healthChanged", health)
	$HP.text = str(health) + "/" + str(stats.max_health) 
	if health <= 0:
		health = 0
		dead = true
		#$explosion/CPUParticles2D.emitting = true
		$Sprite2D/AnimationPlayer.play("idle")
		$Sprite2D/AnimationPlayer.stop()
		$Sprite2D.visible = false
		healthbar.visible = false
		print("Unit is dead!")
		self.queue_free()

func move1_used():
	Global.isPlayerTurn = true
	
func move2_used():
	Global.isPlayerTurn = true
