extends GridContainer

# A collection of InventorySlot-s representing an inventory
class_name Inventory

@export var slotCount : int
@export var starterItems : Array[InventoryItem]

var currentSlot : int = 0
var slots : Array[InventorySlot] = []

func _ready() -> void:
	for i in slotCount:
		var slot = InventorySlot.new()
		slot.name = "InventorySlot" + str(i)
		slot.item = starterItems[i]
		add_child(slot)
		slots.append(slot)
		
func _process(delta: float) -> void:
	# Process slot number keys
	if Input.is_action_just_pressed("Inventory 1"):
		currentSlot = 0
	elif Input.is_action_just_pressed("Inventory 2"):
		currentSlot = 1
	elif Input.is_action_just_pressed("Inventory 3"):
		currentSlot = 2
	elif Input.is_action_just_pressed("Inventory 4"):
		currentSlot = 3
	elif Input.is_action_just_pressed("Inventory 5"):
		currentSlot = 4
	
	# Process plus/minus slot keys
	if Input.is_action_just_pressed("Inventory Plus"):
		currentSlot += 1
	elif Input.is_action_just_pressed("Inventory Minus"):
		currentSlot -= 1
		
	if currentSlot >= slotCount: currentSlot = 0
	if currentSlot < 0: currentSlot = slotCount - 1
		

# Returns the InventoryItem in the current slot
func get_active_item() -> InventoryItem:
	if slots[currentSlot]: return slots[currentSlot].item
	else: return null
	
func remove_item(slot: int) -> void:
	slots[slot].item = null
	
func set_item(item: ItemData, slot: int) -> void:
	var newItem = InventoryItem.new()
	newItem.data = item
	newItem.amount = 1
	slots[slot].item = newItem
