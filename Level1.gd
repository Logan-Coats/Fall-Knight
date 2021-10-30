extends Node2D

func _ready():
	$FadeINOUT/AnimationPlayer.play("fade in")


func _on_Player_dead():
	$Restart/HBoxContainer.visible = true
	$Restart/restart.visible = true
	$Restart/youdied.visible = true


func _on_Button2_pressed():
	get_tree().reload_current_scene()
	PlayerStats.health = 4
	$Restart/HBoxContainer.visible = false
	$Restart/restart.visible = false
	$Restart/youdied.visible = false


func _on_Button_pressed():
	$FadeINOUT/AnimationPlayer.play("fade out")
	get_tree().quit()
	
