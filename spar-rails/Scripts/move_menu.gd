extends Node2D

class_name Moveset

signal move_1
signal move_2

func _onready():
	$VBoxContainer/Move1.self_modulate = Color("ffffff8a")


func _on_move_1_pressed() -> void: #-> void is the return type
	print("Unit used Move 1")
	move_1.emit()
	
func _on_move_2_pressed() -> void:
	print("Unit used Move 2")
	move_2.emit()
