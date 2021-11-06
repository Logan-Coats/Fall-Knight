extends KinematicBody2D

const EnemyDeathEffect = preload("res://Hit Effect/DeathEffect.tscn")
const EnemyDeathSound = preload("res://Enemies/EnemyDeathSound.tscn")
const SkeletonHurtSound = preload("res://Enemies/SkeletonHurtSound.tscn")
const heart = preload("res://Heart.tscn")

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
var dropchance
const mindropchance = 75

onready var stats = $Stats
onready var sprite = $Skeleton
onready var hurtbox = $hurtbox
onready var hitbox = $hitboxpivot/hitbox/collisionshape2d
onready var playerdetectionzone = $PlayerDetectionZone
onready var attackbox = $hitboxpivot/AttackBox/CollisionShape2D
onready var hitboxpivot = $hitboxpivot
onready var afterdeathtimer = $afterdeathtimer

func _ready():
	randomize()
	dropchance = randi() %100

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
			if hurtbox.invincible == false:
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
		DEAD:
			pass
			#do nothing
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
	var skeletonhurtsound = SkeletonHurtSound.instance()
	get_tree().current_scene.add_child(skeletonhurtsound)
	velocity.x = 0
	velocity = move_and_slide(velocity, Vector2.UP)
	hurtbox.start_invincibility(1)

func _on_Stats_nohealth():
	sprite.play("death")
	hitbox.set_deferred("disabled",true)
	hurtbox.collisionshape.set_deferred("disabled",true)
	velocity = Vector2.ZERO
	state = DEAD
	afterdeathtimer.start(5)

func _on_AttackBox_body_entered(body):
	if state != DEAD && hurtbox.invincible == false:
		state = ATTACK

func _on_AttackBox_area_entered(area):
	if state != DEAD && hurtbox.invincible == false:
		state = ATTACK

func _on_afterdeathtimer_timeout():
	queue_free()
	if dropchance > mindropchance:
		var Heart = heart.instance()
		get_tree().current_scene.add_child(Heart)
		Heart.global_position = global_position
	var enemydeathsound = EnemyDeathSound.instance()
	get_tree().current_scene.add_child(enemydeathsound)
	var enemyDeathEffect  = EnemyDeathEffect.instance()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = playerdetectionzone.global_position
