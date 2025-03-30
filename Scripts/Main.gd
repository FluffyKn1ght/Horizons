extends Node2D

# Main game scene script

var player : Node # actually a CharacterBody2D; Player node
var playerCamera : Camera2D # Player camera
var HUD : CanvasLayer # Game HUD parent node

func _ready() -> void:
	# Spawn in player
	player = preload("res://Objects/Player.tscn").instantiate()
	player.position = Vector2(80, 80) # temp!!!
	add_child(player)

	# Initialize player camera
	playerCamera = Camera2D.new()
	playerCamera.position_smoothing_enabled = true
	player.add_child(playerCamera)
	
	# Setup HUD variable
	HUD = find_child("HUD")
	
func _process(delta: float) -> void:
	# Process HUD
	# Healthbar
	var playerHealth : HealthComponent = player.find_child("HealthComponent")
	$HUD/Healthbar.value = playerHealth.health
	$HUD/Healthbar.max_value = playerHealth.maxHealth
	
	# Update player hand sprite
	var currentItem : InventoryItem = $HUD/Inventory.get_active_item()
	if currentItem != null:
		player.find_child("Hand").texture = currentItem.data.texture
	else:
		player.find_child("Hand").texture = null
