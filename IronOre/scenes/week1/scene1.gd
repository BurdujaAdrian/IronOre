extends Node2D

var text_speed = 60
@onready var dialogue_box = $text_ui/PanelContainer/RichTextLabel
var text_length:int = 0
var display_text_len:float = 0
# Called when the node enters the scene tree for the first time.

var text_lines = [
	"line 1",
	"line 2",
	"line 3",
	"line 4",
	"line 5",
	"line 6",	
	"line 7",
	"line 8",
	"line 9",	
	"line 10",
	"line 11",
	"line 12",
]

var line_timeout:float=0.5

func _ready():
	dialogue_box.text = text_lines[Global.last_line_id]
	
func _process(delta: float):
	text_length = len(dialogue_box.text)
	if dialogue_box.visible_characters < text_length :
		display_text_len += delta*text_speed
		dialogue_box.visible_characters = floor(display_text_len)
	
	if line_timeout > 0 :
		line_timeout-=delta
		print(line_timeout)
	pass

func _next_line() :
	dialogue_box.text = text_lines[Global.last_line_id]
	Global.last_line_id +=1

	dialogue_box.visible_characters = 0
	pass

func _input(event:InputEvent) -> void:
	if event is InputEventMouseButton :
		if event.button_index == 1:
			var no_mouse =$Control/No_mouse.get_rect()
			if (
			dialogue_box.visible_characters == len(dialogue_box.text)
			&& line_timeout < 0
			&& 	Global.last_line_id < len(text_lines) -1
			&&  !no_mouse.has_point(get_local_mouse_position())
			):
				line_timeout = 0.5
				_next_line()
				
			dialogue_box.visible_characters = len(dialogue_box.text)
