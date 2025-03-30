extends TextureRect

# A slot that holds an InventoryItem. Meant to be a child of an Inventory
class_name InventorySlot

@export var item : InventoryItem # The item this slot is holding
# Slot textures - normal and active (selected)
@export var normalTexture : Texture2D = load("res://Assets/Resources/InventorySlotTexture.tres")
@export var activeTexture : Texture2D = load("res://Assets/Resources/InventorySlotTexture-Active.tres")

var itemSprite : Sprite2D # The preview sprite of the item
var itemCount : Label # The label with the item count

func _ready() -> void:
	# Initialize item sprite and count label
	itemSprite = Sprite2D.new()
	itemSprite.position = Vector2(8.0, 8.0)
	itemSprite.scale = Vector2(0.5, 0.5)
	add_child(itemSprite)
	
	itemCount = Label.new()
	itemCount.label_settings = load("res://Assets/Resources/InventorySlotCountLabelSettings.tres")
	itemCount.position = Vector2(13.0, 12.75)
	itemCount.scale = Vector2(0.075, 0.075)
	add_child(itemCount)

func _process(delta: float) -> void:
	# Update slot texture based on currently selected slot
	if str(get_parent().currentSlot) == name.split("InventorySlot")[1]:
		texture = activeTexture
	else: texture = normalTexture
	
	# Update item sprite and count label
	if item != null:
		itemSprite.texture = item.data.texture
		itemCount.text = str(item.amount)
	else:
		itemSprite.texture = null
		itemCount.text = ""
		
