extends Node2D

# Main game scene script

var blockList : DictionaryAsAResource = load("res://Assets/Resources/BlockList.tres")

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
	player.add_child(crosshair)

	# Initialize player camera
	playerCamera = Camera2D.new()
	playerCamera.position_smoothing_enabled = true
	playerCamera.drag_horizontal_enabled = true
	playerCamera.drag_vertical_enabled = true
	player.add_child(playerCamera)
	
	# Setup HUD variable
	HUD = find_child("HUD")
	
func _process(delta: float) -> void:
	# Update healthbar
	var playerHealth : HealthComponent = player.find_child("HealthComponent")
	$HUD/Healthbar.value = playerHealth.health
	$HUD/Healthbar.max_value = playerHealth.maxHealth
	
	# Update player hand sprite and crosshair mode/texture
	var currentItem : InventoryItem = $HUD/Inventory.get_active_item()
	if currentItem != null:
		player.find_child("Hand").texture = currentItem.data.texture
		
		if currentItem.data is BlockItemData:
			crosshair.cursorMode = "Block"
			crosshair.snapToTiles = true
	else:
		player.find_child("Hand").texture = null
		
		crosshair.cursorMode = "Block"
		crosshair.snapToTiles = false
		
	# Handle block manipulation
	# TODO: make this drop items (task for milestone 2)
	if Input.is_action_just_pressed("Place"):
		if currentItem != null:
			if currentItem.data is BlockItemData:
				var blockAtlasPosition : Vector2i = blockList.dictionary[currentItem.data.blockType]
				var tilemapPosition : Vector2i = floor(crosshair.global_position / Vector2(64, 64))
				if $PlayerTiles.get_cell_atlas_coords(tilemapPosition) == Vector2i(-1, -1):
					$PlayerTiles.set_cell(tilemapPosition, 0, blockAtlasPosition)
					currentItem.amount -= 1
	elif Input.is_action_just_pressed("Break"):
				var tilemapPosition : Vector2i = floor(crosshair.global_position / Vector2(64, 64))
				if currentItem != null:
					if $PlayerTiles.get_cell_atlas_coords(tilemapPosition) == blockList.dictionary[currentItem.data.name]:
						currentItem.amount += 1
				else:
					$HUD/Inventory.set_item(load("res://Assets/Resources/Items/WoodBlock.tres"), $HUD/Inventory.currentSlot)
				$PlayerTiles.erase_cell(tilemapPosition)
				
	# Handle current item quantity
	if currentItem:
		if not currentItem.amount:
			$HUD/Inventory.remove_item($HUD/Inventory.currentSlot)
