extends Node

class_name Unit

signal healthChanged
signal skillUsed

var max_health
var previous_health = health
var health = max_health
var dead = false

@onready var sprite = $Sprite2D
@onready var healthbar: ProgressBar = $Healthbar
@onready var MoveMenu = $MoveMenu
@onready var move_menu: Moveset = $MoveMenu
@export var stats: UnitStats
var enemies = []
var isBouncing

func _ready():
	$Sprite2D.texture = stats.characterSprite
	$Weakness.texture = stats.weaknessSprite
	$Name.text = stats.character_name
	$MoveMenu/VBoxContainer/Move1.text = stats.move1_name
	$MoveMenu/VBoxContainer/Move2.text = stats.move_2_name
	$MoveMenu/VBoxContainer/Move1.tooltip_text = stats.move1_description
	$MoveMenu/VBoxContainer/Move2.tooltip_text = stats.move_2_description
	enemies = get_tree().get_nodes_in_group("HostileUnits")
	health = stats.max_health
	healthbar.init_health(health)
	$HP.text = str(health) + "/" + str(stats.max_health) 
	isBouncing = false
	move_menu.move_1.connect(move1_used)
	move_menu.move_2.connect(move2_used)

func _process(delta):
	if Global.isPlayerTurn and isBouncing == false:
		$Sprite2D/AnimationPlayer.play("Bounce")
		isBouncing = true
	elif Global.isPlayerTurn == false:
		$Sprite2D/AnimationPlayer.play("Idle")
		MoveMenu.visible = false
		isBouncing = false

	if Global.selectingTarget:
			for enemy in enemies:
				print(enemy.stats.character_name)
				


func _on_area_2d_mouse_entered():
	print("Mouse entered Area2D!")


func _on_area_2d_mouse_exited():
	print("Mouse exited Area2D!")


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and Global.isPlayerTurn and Global.selectingTarget == false:
		if (MoveMenu.visible == false):
			MoveMenu.visible = true
		else:
			MoveMenu.visible = false


			
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
		$explosion/CPUParticles2D.emitting = true
		$Sprite2D/AnimationPlayer.play("idle")
		$Sprite2D/AnimationPlayer.stop()
		$Sprite2D.visible = false
		healthbar.visible = false
		print("Unit is dead!")
		self.queue_free()


func move1_used():
	MoveMenu.visible = false
	Global.selectingTarget = true
	Global.selectedMoveType = stats.move1_element
	Global.selectedMoveDamage = stats.move1_damage
	enemies = get_tree().get_nodes_in_group("HostileUnits")
	
func move2_used():
	MoveMenu.visible = false
	Global.selectingTarget = true
	Global.selectedMoveType = stats.move_2_element
	Global.selectedMoveDamage = stats.move_2_damage
	enemies = get_tree().get_nodes_in_group("HostileUnits")
