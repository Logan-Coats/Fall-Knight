extends Control

func _ready():
	$FadeINOUT/AnimationPlayer.play("fade in")

func _input(event):
	if event is InputEventKey:
		$FadeINOUT/AnimationPlayer.play("fade out")
		$Timer.start(1)


func _on_Timer_timeout():
	get_tree().change_scene("res://Level1.tscn")
