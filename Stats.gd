extends Node

export(int) var maxhealth = 1 setget set_max_health

var health = maxhealth setget set_health

signal nohealth
signal health_changed(value)
signal max_health_changed(value)

func set_max_health(value):
	maxhealth = value
	self.health = min(health,maxhealth)
	emit_signal("max_health_changed",maxhealth)


func set_health(value):
	health = value
	emit_signal("health_changed", health)
	if health <= 0:
		emit_signal("nohealth")

func _ready():
	self.health = maxhealth
