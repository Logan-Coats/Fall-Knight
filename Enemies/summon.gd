extends KinematicBody2D

const heart = preload("res://Heart.tscn")

export var acceleration = 300
export var maxspeed = 150
export var friction = 200

onready var animp = $AnimationPlayer
onready var playerdetectionzone = $PlayerDetectionZone
onready var sprite = $Sprite

var velocity = Vector2.ZERO
var dead = false
var dropchance
var mindropchance = 25

func _ready():
	animp.play("spawn")
	randomize()
	

func _physics_process(delta):
	if !dead:
		if !animp.is_playing():
			animp.play("idle")
		if playerdetectionzone.can_see_player():
			var player = playerdetectionzone.player
			if player != null:
				accelerate_towards_point(player.global_position, delta)
			velocity = move_and_slide(velocity, Vector2.DOWN)


func accelerate_towards_point(point,delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * maxspeed, acceleration * delta)
	sprite.flip_h = direction.x > 0


func _on_hurtbox_area_entered(area):
	animp.play("death")
	$hitbox/collisionshape2d.set_deferred("disabled",true)
	dead = true
	$Timer.start(1)


func _on_Timer_timeout():
	dropchance = randi() %100
	if dropchance > mindropchance:
		var Heart = heart.instance()
		get_tree().current_scene.add_child(Heart)
		Heart.global_position = global_position
	queue_free()
