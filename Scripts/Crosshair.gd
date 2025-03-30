extends Sprite2D

# A crosshair used by the build system
class_name Crosshair

var player : Player # The player node of the crosshair
var area : Area2D # The collision detection area

var snapToTiles : bool = true # Whether the cursor snaps to the tile grid
@export_enum("Block", "Weapon") var cursorMode : String = "Block"

func _ready() -> void:
	# Initialize crosshair
	texture = load("res://Assets/Sprites/crosshair-block.png")
	scale = Vector2(4, 4)
	z_index = 5
	
	# Initialize hitbox
	area = Area2D.new()
	add_child(area)
	var areaShape : CollisionShape2D = CollisionShape2D.new()
	var areaShapeObj : Shape2D = RectangleShape2D.new()
	areaShapeObj.size = Vector2(32, 32)
	areaShape.shape = areaShapeObj
	area.add_child(areaShape)
	area.set_collision_layer_value(7, true)
	area.set_collision_mask_value(8, true)
	
func _process(delta: float) -> void:
	# Do crosshair stuff
	if snapToTiles:
		global_position = (round(get_global_mouse_position() / Vector2(64, 64)) * Vector2(64, 64)) + Vector2(32, 32)
	else: global_position = get_global_mouse_position()
	
	# Make crosshair semi-transparent if it's on top of the player (if one was specified)
	if player != null:
		if player.find_child("Area") in area.get_overlapping_areas():
			self_modulate = Color(1, 1, 1, 0.5)
		else: self_modulate = Color(1, 1, 1, 1)
