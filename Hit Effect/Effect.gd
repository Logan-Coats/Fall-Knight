extends AnimatedSprite


func _ready():
	frame = 0
	play("animate")


func _on_DeathEffect_animation_finished():
	queue_free()


func _on_HitEffect_animation_finished():
	queue_free()
