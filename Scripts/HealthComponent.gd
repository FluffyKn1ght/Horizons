extends Node
# An object that stores health data
class_name HealthComponent

signal Dead # Gets emitted when health falls to 0

@export var health : int = 10 # Current health level
@export var maxHealth : int = 10 # Max health level

func changeHp(amount : int):
	health -= amount
	if (health <= 0 ):
		Dead.emit()
