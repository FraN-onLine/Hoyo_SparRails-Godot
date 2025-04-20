extends Node2D

# Global variable to track unit count
onready var global_unit_count = get_node("/root/Global").unit_count

# Array to store deployed units
var deployed_units = []

# Maximum number of units allowed in the deployment area
const MAX_UNITS = 3

func _ready():
    # Initialize the deployment area
    deployed_units = []

func _on_unit_dropped(unit_instance):
    if deployed_units.size() < MAX_UNITS:
        # Add the unit to the deployment area
        deployed_units.append(unit_instance)
        global_unit_count += 1
        print("Unit deployed. Total units on field:", global_unit_count)
    else:
        print("Deployment area is full!")

func _on_unit_removed(unit_instance):
    if unit_instance in deployed_units:
        # Remove the unit from the deployment area
        deployed_units.erase(unit_instance)
        global_unit_count -= 1
        print("Unit removed. Total units on field:", global_unit_count)

func _input(event):
    if event is InputEventMouseMotion and Input.is_action_pressed("drag_unit"):
        # Handle dragging logic here
        pass
    elif event is InputEventMouseButton and event.is_pressed():
        # Handle dropping logic here
        pass