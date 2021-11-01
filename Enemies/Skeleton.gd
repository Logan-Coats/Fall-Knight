extends KinematicBody2D


const FRICTION = 500
const ACCELERATION = 500
const MAX_SPEED = 50
const GRAVITY = 1000

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
onready var hitbox = $hitboxpivot/hitbox/collisionshape2d
onready var playerdetectionzone = $PlayerDetectionZone
onready var attackbox = $hitboxpivot/AttackBox/CollisionShape2D
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
			sprite.play("idle")
			seek_player()
		CHASE:
			if hurtbox.invincible == false:
				sprite.play("walk")
				var player = playerdetectionzone.player
				if player != null:
					accelerate_towards_point(player.global_position,delta)
				else: state = IDLE
		ATTACK:
			velocity = Vector2.ZERO
			if faceright:
				sprite.position.x = 12
				sprite.position.y = -4
			else:
				sprite.position.x = -12
				sprite.position.y = -4
			sprite.play("attack")
			if sprite.frame == 6 ||sprite.frame == 7 ||sprite.frame == 8 ||sprite.frame == 9:
				hitbox.disabled = false
			else: hitbox.disabled = true
			
			if sprite.frame == 17:
				sprite.position.x = 0
				sprite.position.y = 0
				state = IDLE
			#play attack animation, having hitbox enabled on specific frames.
			#move sprite 12,-4 on faceright = true when false do -12,-4
			#when animation is done, state = IDLE
			#move sprite back to 0,0
		DEAD:
			pass
			#do nothing, or when animation ends, enemy death effect
	velocity.y += GRAVITY*delta
	velocity = move_and_slide(velocity, Vector2.UP)
	


func seek_player():
	if playerdetectionzone.can_see_player():
		state = CHASE

func accelerate_towards_point(point,delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	sprite.flip_h = direction.x < 0
	if sprite.flip_h == true:
		faceright = false
	else: 
		faceright = true

func _on_hurtbox_area_entered(area):
	sprite.play("hurt")
	stats.health -= area.damage 
	knockback = area.knockbackvector * 120
	velocity.x = 0
	velocity = move_and_slide(velocity, Vector2.UP)
	hurtbox.start_invincibility(1)
	#hit effect
	#hurtbox.create_hurt_effect()

func _on_Stats_nohealth():
	sprite.play("death")
	hitbox.disabled = true
	hurtbox.collisionshape.disabled = true
	velocity = Vector2.ZERO
	state = DEAD

func _on_AttackBox_body_entered(body):
	if state != DEAD && hurtbox.invincible == false:
		state = ATTACK


func _on_AttackBox_area_entered(area):
	if state != DEAD && hurtbox.invincible == false:
		state = ATTACK
	
