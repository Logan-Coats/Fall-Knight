extends Node2D

func _ready():
	$FadeINOUT/AnimationPlayer.play("fade in")


func _on_Player_dead():
	pass
	#request restart or end. (with label 
	#and button or mouse input.)
