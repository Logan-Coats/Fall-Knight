extends AudioStreamPlayer

func _ready():
	connect("finished",self,"queue_free")



func _on_PlayerDeathSound_finished():
	queue_free()
