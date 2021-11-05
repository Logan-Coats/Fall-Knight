extends Node2D

onready var music = $AudioStreamPlayer
onready var timer = $Timer
export var playerhealth = 4
export var level = 0

var levellist = ["res://Level1.tscn","res://Level2.tscn","res://Level3.tscn"]
var dead = false
func _ready():
	$FadeINOUT/AnimationPlayer.play("fade in")
	PlayerStats.health = playerhealth
	dead = false
	music.play()

func _process(_delta):
	if music.playing == false && dead == false:
		music.play()

func _on_Player_dead():
	music.stop()
	dead = true
	$Restart/HBoxContainer.visible = true
	$Restart/restart.visible = true
	$Restart/youdied.visible = true


func _on_Button2_pressed():
	get_tree().reload_current_scene()
	PlayerStats.health = playerhealth
	$Restart/HBoxContainer.visible = false
	$Restart/restart.visible = false
	$Restart/youdied.visible = false


func _on_Button_pressed():
	$FadeINOUT/AnimationPlayer.play("fade out")
	
	get_tree().quit()
	


func _on_Area2D_body_entered(_body):
	$FadeINOUT/AnimationPlayer.play("fade out")
	timer.start(1)


func _on_Timer_timeout():
	music.stop()
	get_tree().change_scene(levellist[level+1])
