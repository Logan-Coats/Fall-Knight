extends Control

onready var music = $AudioStreamPlayer
var bro = true
func _ready():
	$FadeINOUT/AnimationPlayer.play("fade in")
	$AnimationPlayer.play("text fade")

func _input(event):
	if event is InputEventKey && bro:
		bro = false
		$FadeINOUT/AnimationPlayer.play("fade out")
		$gamestart.play()
		$Timer.start(1)

func _on_Timer_timeout():
	music.stop()
	get_tree().change_scene("res://Level1.tscn")
