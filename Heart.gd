extends Area2D



func _on_Heart_body_entered(body):
	if PlayerStats.health != PlayerStats.maxhealth:
		PlayerStats.health += 1
	$CollisionShape2D.set_deferred("disabled",true)
	$AudioStreamPlayer.play()
	$Sprite.visible = false
	$Timer.start(.5)


func _on_Timer_timeout():
	queue_free()
