extends Node

# An object that stores health data
class_name HealthComponent

signal Dead # Gets emitted when health falls to 0

@export var health : int = 10 # Current health level
@export var maxHealth : int = 10 # Max health level

var process : bool = true # Whether to process death

func _process(delta: float) -> void:
	# Turn on processing if our health is above 0
	if health and not process:
		process = true
	# If our health falls below 0, emit signal Dead and turn processing off
	if health <= 0 and process:
		Dead.emit()
		process = false
