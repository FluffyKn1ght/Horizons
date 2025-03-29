extends CharacterBody2D

const MAX_SPEED : float = 400.0 # The max value of velocity.x and velocity.y
const ACCEL_MULTI : float = 50.0 # How fast the player accelerates (0.0-whatever)
const DECEL_MULTI : float = 0.75 # How fast the player decelarates (0.0-0.9999)

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
	
	# --- Do movement
	# Accellerate if player is holding down button
	if joystickx != 0 or joysticky != 0:
		velocity += Vector2(ACCEL_MULTI * joystickx, ACCEL_MULTI * joysticky)
	# Decelerate otherwise
	else:
		velocity *= Vector2(DECEL_MULTI, DECEL_MULTI)
	velocity = velocity.limit_length(MAX_SPEED) # Cap the speed
	
	# --- Animation and flipping
	# Detect which direction to face in
	# Run this only when we're moving
	if joystickx != 0 or joysticky != 0:
		if joystickx != 0: direction = "Side"
		elif joysticky < 0: direction = "Up"
		else: direction = "Down"
	# Idle animation
	if joystickx == 0 and joysticky == 0:
		$Sprite.play("Idle " + direction)
	# Walking animation
	else:
		$Sprite.play("Walk " + direction)
		# Flip the sprite if we're going left
		if joystickx < 0: $Sprite.flip_h = true
		else: $Sprite.flip_h = false

	move_and_slide()
