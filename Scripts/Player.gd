extends CharacterBody2D

const SPEED : float = 5 # How much the player moves each frame

var direction : String = "Down" # The sprite direction of the player as a word. Up/Down/Side

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# === Handle input
	# --- Set axis variables
	var joystickx = Input.get_axis("Left", "Right")
	var joysticky = Input.get_axis("Up", "Down")
	
	# --- Super basic janky movement
	position += Vector2(
		SPEED * joystickx, # X
		SPEED * joysticky # Y
	).limit_length(SPEED) # Cap the speed
	
	# --- Detect which direction to face in
	# Run this only when we're moving
	if joystickx != 0 or joysticky != 0:
		if joystickx != 0: direction = "Side"
		elif joysticky < 0: direction = "Up"
		else: direction = "Down"
	
	# --- Animation and flipping
	# Idle animation
	if joystickx == 0 and joysticky == 0:
		$Sprite.play("Idle " + direction)
	# Walking animation
	else:
		$Sprite.play("Walk " + direction)
		# Flip the sprite if we're going left
		if joystickx < 0: $Sprite.flip_h = true
		else: $Sprite.flip_h = false
