extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	save()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Let's assume the PlayerNode is the node where we save the player data in game

var save_path := "user://player_data.ini"

# To save data
func save() -> void:
	var config_file := ConfigFile.new()
	
	config_file.set_value("Player", "health", 10)
	config_file.set_value("Player", "name", "name")
	config_file.set_value("Player", "points", 100)

	print(config_file)
	var error := config_file.save(save_path)
	print("error: ",error)
	if error:
		print("An error happened while saving data: ", error)

# To load data
func load() -> void:
	var config_file := ConfigFile.new()
	var error := config_file.load(save_path)

	if error:
		print("An error happened while loading data: ", error)
		return

	print("loaded: ",config_file.get_value("Player", "health", 1))
	print("loaded: ",config_file.get_value("Player", "name", "UNDEFINED"))
	print("loaded: ",config_file.get_value("Player", "points", 0.0))
