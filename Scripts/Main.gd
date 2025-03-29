extends Node2D

var player : Node # actually a CharacterBody2D
var playerCamera : Camera2D

func _ready() -> void:
	player = preload("res://Objects/Player.tscn").instantiate()
	player.position = Vector2(80, 80) # temp!!!
	add_child(player)

	playerCamera = Camera2D.new()
	playerCamera.position_smoothing_enabled = true
	player.add_child(playerCamera)
	
func _process(delta: float) -> void: pass
