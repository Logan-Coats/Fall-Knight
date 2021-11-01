extends Area2D

onready var timer = $Timer
onready var timer2 = $Timer2
onready var collisionshape = $CollisionShape2D

var invincible = false setget set_invincible
var moveable = true

signal invincibility_start
signal invincibility_end

func set_invincible(value):
	invincible = value
	if invincible == true:
		emit_signal("invincibility_start")
		moveable = false
	else:
		emit_signal("invincibility_end")
		

func start_invincibility(duration):
	self.invincible  = true
	self.moveable = false
	timer2.start(duration/2)
	timer.start(duration)

func _on_Timer_timeout():
	self.invincible = false

func _on_hurtbox_invincibility_end():
	collisionshape.disabled = false

func _on_hurtbox_invincibility_start():
	collisionshape.set_deferred("disabled", true)

func _on_Timer2_timeout():
	moveable = true

