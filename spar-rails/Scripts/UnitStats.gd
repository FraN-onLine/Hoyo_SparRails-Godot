extends Resource

class_name UnitStats

@export var character_name: String = "Default Name" #export means it can be set in the editor
@export var character_element: String = "Typeless"
@export var weakness: String ="Typeless"
@export var weaknessSprite: Texture2D
@export var max_health: int = 100
@export var characterSprite: Texture2D

@export var move1_name: String = "Default Move 1"
@export var move1_damage: int = 10
@export var move1_element: String = "Physical"
@export var move1_description: String = "Default Move 1 Description"
@export var move1_type: String = "Elemental"
@export var move1_target: String = "Enemy"

@export var move_2_name: String = "Default Move 2"
@export var move_2_damage: int = 10
@export var move_2_element: String = "Fire"
@export var move_2_description: String = "Default Move 2 Description"
@export var move_2_type: String = "Shield"
@export var move_2_target: String = "Self"
