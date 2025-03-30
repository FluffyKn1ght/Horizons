extends Node2D

# Main game scene script

var player : Player # Player node
var playerCamera : Camera2D # Player camera
var HUD : CanvasLayer # Game HUD parent node
var crosshair : Crosshair # Player crosshair

func _ready() -> void:
	# Hide system cursor (might move this to a higher object)
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	
	# Spawn in player
	player = preload("res://Objects/Player.tscn").instantiate()
	player.position = Vector2(80, 80) # temp!!!
	add_child(player)
	
	# Create crosshair object
	crosshair = Crosshair.new()
	crosshair.player = player
	add_child(crosshair)

	# Initialize player camera
	playerCamera = Camera2D.new()
	playerCamera.position_smoothing_enabled = true
	playerCamera.drag_horizontal_enabled = true
	playerCamera.drag_vertical_enabled = true
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
