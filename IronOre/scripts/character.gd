extends Node2D

@onready var character_name_label = $Character/Control/CharacterName

func show_character_name(name: String)->String:
	if ":" in name:
		var parts = name.split(": ", false, 1)
		character_name_label.text = parts[0]
		return parts[1]
	return name

func load_character(data):
	pass
