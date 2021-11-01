extends KinematicBody2D


const FRICTION = 500
const ACCELERATION = 500
const MAX_SPEED = 120
const GRAVITY = 400

enum{
	IDLE,
	CHASE,
	ATTACK,
	DEAD
}

var velocity = Vector2.ZERO
var knockback = Vector2.ZERO
var state = CHASE
var faceright = true

onready var stats = $Stats
onready var sprite = $Skeleton
onready var hurtbox = $hurtbox
onready var playerdetectionzone = $PlayerDetectionZone
onready var hitboxpivot = $hitboxpivot

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION*delta)
	knockback = move_and_slide(knockback)
	if faceright == false:
		hitboxpivot.rotation_degrees = 180
	else:
		hitboxpivot.rotation_degrees = 0
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player()
		CHASE:
			var player = playerdetectionzone.player
			if player != null:
				accelerate_towards_point(player.global_position,delta)
			else: state = IDLE
		ATTACK:
			pass
		DEAD:
			pass
	velocity.y += GRAVITY*delta
	velocity = move_and_slide(velocity, Vector2.UP)
	


func seek_player():
	if playerdetectionzone.can_see_player():
		state = CHASE

func accelerate_towards_point(point,delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	sprite.flip_h = direction.x > 0
	if sprite.flip_h == true:
		faceright = false

func _on_hurtbox_area_entered(area):
	stats.health -= area.damage 
	knockback = area.knockbackvector * 120
	#hit effect
	#hurtbox.create_hurt_effect()

func _on_Stats_nohealth():
	sprite.play("death")
	state = DEAD
