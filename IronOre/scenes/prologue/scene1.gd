extends Node2D

var text_speed = 60
@onready var dialogue_box = $text_ui/PanelContainer/RichTextLabel
var text_length:int = 0
var display_text_len:float = 0
# Called when the node enters the scene tree for the first time.

var text_lines = [
"Cassy is a model university student with perfect grades and attendance.
He is fascinated by the world of computer science.
In particular, Cassy is amazed by programming langueges.
One day, he saw a video where a streamer wrote a simple programming language in just a few hours.
Cassy got inspired to make one of his own for the sake of experience.
However, Cassy didn't have any ideas for the shape of the languege neither he had enough free time to actually work on his languege.
So, Cassy postponed this adventure for later.",

"Months later, Cassy's motivation is restored by a article that compares existing languages.
He notices that all of the languages miss what he thinks will be a key feature of his language and if he succedes it will revolutionise the industry.
With a pumping heart, Cassy dives in the research of languages' inner workings.
He swims in the wonderful world of parsers, tokenizers, abstract sintax tress and the ellusive assembly languege.
"]

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
