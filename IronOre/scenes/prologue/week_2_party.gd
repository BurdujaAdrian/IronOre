extends Node2D

var text_speed = 60
@onready var dialogue_box = $text_ui/PanelContainer/RichTextLabel
@onready var character_name_label = $text_ui/CharacterName
var text_length:int = 0
var display_text_len:float = 0
var line_id:int = 0
var line_timeout:float = 0.5
var tween

var text_lines = [
	"Ian: Ugh, this first week is already so overwhelming...",
	"Ion: Tell me about it. I thought I was prepared, but I feel like I’m drowning in work.",
	"Ian: Yeah... I was starting to think I was the only one struggling.",
	"Ion: No way, man. I barely understood half of what the professor said today.",
	"Ian: Same! I was too afraid to ask questions though.",
	"Ion: Honestly? Me too. Maybe we should just team up and figure things out together.",
	"Ian: You mean like study together?",
	"Ion: Yeah! Two confused minds are better than one, right?",
	"Ian: You know what? That actually sounds like a great idea. I’m Ian, by the way.",
	"Ion: Nice to meet you, Ian. Let’s survive this together!"
]

func _ready():
	line_id = 0
	display_text()

func _process(delta: float):
	text_length = len(dialogue_box.text)
	if dialogue_box.visible_characters < text_length:
		display_text_len += delta * text_speed
		dialogue_box.visible_characters = floor(display_text_len)

	if line_timeout > 0:
		line_timeout -= delta

func show_character_name(name: String):
	character_name_label.text = name

	if name == "Ian":
		character_name_label.position.y -= 10  # Smaller initial movement for smoother effect

		if tween:
			tween.kill()
		tween = get_tree().create_tween()
		tween.tween_property(character_name_label, "position:y", character_name_label.position.y + 10, 0.5).set_trans(Tween.TRANS_BOUNCE)  # Slower bounce (0.5s)
	else:
		character_name_label.position.y = 0  # Reset position for Ion

func display_text():
	if line_id < len(text_lines):
		var current_text = text_lines[line_id]
		
		if ":" in current_text:
			var parts = current_text.split(": ", false, 1)
			show_character_name(parts[0])
			current_text = parts[1]

		dialogue_box.text = current_text
		dialogue_box.visible_characters = 0
		display_text_len = 0

func _next_line():
	if line_id < len(text_lines) - 1:
		line_id += 1
		display_text()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == 1:
		if dialogue_box.visible_characters < len(dialogue_box.text):
			dialogue_box.visible_characters = len(dialogue_box.text)
		elif line_id < len(text_lines) - 1:
			line_timeout = 0.5
			_next_line()
