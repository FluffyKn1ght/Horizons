extends Resource

# Base resource for other item data classes to extend.
class_name ItemData

@export var texture : Texture2D 
@export var name : String = "New Item"
@export var tooltip : String = "This is a test tooltip"
@export var maxStack : int
