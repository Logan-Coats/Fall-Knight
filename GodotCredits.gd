extends Node2D

const section_time := 2.0
const line_time := 0.3
const base_speed := 100
const speed_up_multiplier := 10.0
const title_color := Color.blueviolet

var scroll_speed := base_speed
var speed_up := false

onready var line := $CreditsContainer/Line
onready var fadein = $FadeINOUT/AnimationPlayer
var started := false
var finished := false

var section
var section_next := true
var section_timer := 0.0
var line_timer := 0.0
var curr_line := 0
var lines := []

var credits = [
	[
		"A game by Logan Coats",
		"Created for the Fall 2021 ACM Game Jam"
	],[
		"Assets",
		"Autumn Birches                Popcornflood",
		"Dungeon Tileset                   CorwinZX",
		"Enemy death effect              HeartBeast",
		"Hit Effect                      HeartBeast",
		"Input Prompts                       Kenney",
		"Medieval Warrior Pack            Luiz Melo",
		"Parallax Mountain Background       Ansimuz",
		"Sample Credits Code             Ben Bishop",
		"Skeleton Sprite Pack               Jesse M"
	],[
		"Music and SFX",
		"Halloween Music Pack 2018  Sebastian Schwamm",
		"Lost                                  Makoto",
		"8-bit Death Whirl Sound                 Fupi",
		"8-bit Game Sound Effects           Harvey656" 
	],[
		"Fonts",
		"BitPotion  Joe Brogers",
		"Middle            Gowl"
	],[
		"Testers",
		"Logan Coats"
	],[
		"Tools used",
		"Developed with Godot Engine",
		"https://godotengine.org/license",
		"",
		"Assets obtained from various sources, check",
		"https://github.com/LoganCoats22/Fall-Knight",
		"for information and citations."
	],[
		"Special thanks",
		"Association of Computing Machinery",
		"NorthWest Missouri State University"
	]
]
func _ready():
	fadein.play("fade in")

func _process(delta):
	var scroll_speed = base_speed * delta
	
	if section_next:
		section_timer += delta * speed_up_multiplier if speed_up else delta
		if section_timer >= section_time:
			section_timer -= section_time
			
			if credits.size() > 0:
				started = true
				section = credits.pop_front()
				curr_line = 0
				add_line()
	
	else:
		line_timer += delta * speed_up_multiplier if speed_up else delta
		if line_timer >= line_time:
			line_timer -= line_time
			add_line()
	
	if speed_up:
		scroll_speed *= speed_up_multiplier
	
	if lines.size() > 0:
		for l in lines:
			l.rect_position.y -= scroll_speed
			if l.rect_position.y < -l.get_line_height():
				lines.erase(l)
				l.queue_free()
	elif started:
		finish()


func finish():
	if not finished:
		finished = true
		fadein.play("fade out")
		$Timer.start(1)
		# NOTE: This is called when the credits finish
		# - Hook up your code to return to the relevant scene here, eg...
		#get_tree().change_scene("res://scenes/MainMenu.tscn")


func add_line():
	var new_line = line.duplicate()
	new_line.text = section.pop_front()
	lines.append(new_line)
	if curr_line == 0:
		new_line.add_color_override("font_color", title_color)
	$CreditsContainer.add_child(new_line)
	
	if section.size() > 0:
		curr_line += 1
		section_next = false
	else:
		section_next = true


func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		finish()
	if event.is_action_pressed("ui_down") and !event.is_echo():
		speed_up = true
	if event.is_action_released("ui_down") and !event.is_echo():
		speed_up = false


func _on_Timer_timeout():
	get_tree().change_scene("res://Main Menu.tscn")
